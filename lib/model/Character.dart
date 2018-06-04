import 'package:trevas/model/Attribute.dart';
import 'package:trevas/model/AttributeType.dart';
import 'package:trevas/model/Enhancement.dart';
import 'package:trevas/model/Equipment.dart';
import 'package:trevas/model/EquipmentType.dart';
import 'package:trevas/model/Experience.dart';
import 'package:trevas/model/Expertise.dart';
import 'package:trevas/model/Gender.dart';
import 'package:trevas/model/Item.dart';
import 'package:trevas/model/Weapon.dart';
import 'package:trevas/model/WeaponMastery.dart';

class Character {
  final String id;

  /// Character photo URL.
  Uri photo;
  /// Character weight.
  int wight;
  /// Character height.
  int height;
  /// Character actual age.
  int age;
  /// Character apparent age.
  int apparentAge;
  /// Character gold and resources.
  int resources;
  /// Character gender.
  Gender gender;
  /// Character name.
  String name;
  /// Character birthplace.
  String birthplace;
  /// Character job.
  String job;
  /// Character religion.
  String religion;
  /// Character lore or description.
  String lore;
  /// Character birthday.
  DateTime birthday;
  /// Character equipments
  final Equipments equipments = Equipments();
  /// List of languages spoken by the character.
  final List<String> languages = List();
  /// Character experience. Determines the character level.
  final Experience experience = Experience();
  /// All kinds of attributes are here. Health, strength, faith, magic, focus,
  /// initiative are some of them.
  final Attributes attributes = Attributes();
  /// These are masteries specific to a weapon type.
  final List<WeaponMastery> weaponMasteries = List();
  /// This is the list of character masteries.
  /// Examples include swimming, driving, dealing with explosives, jumping,
  /// furtiveness, leadership, ect.
  final List<Mastery> masteries = List();
  /// List of all powers for this character.
  /// Powers include extra attacks, wings, etc.
  final List<Enhancement> powers = List();
  /// List of all improvements for this character.
  /// Improvements include heroic points, magic objects, et al.
  final List<Enhancement> improvements = List();
  /// Contains all items the character is carrying including items that
  /// are currently equipped.
  final List<Item> items = List();

  Character(this.id);
}

class Attributes {
  static const _exceptions = [ AttributeType.damage];

  get constitution => _values[AttributeType.constitution];
  get strength => _values[AttributeType.strength];
  get dexterity => _values[AttributeType.dexterity];
  get agility => _values[AttributeType.agility];
  get intelligence => _values[AttributeType.intelligence];
  get willpower => _values[AttributeType.willpower];
  get perception => _values[AttributeType.perception];
  get charisma => _values[AttributeType.charisma];
  get healthPoints => _values[AttributeType.healthPoints];
  get magicPoints => _values[AttributeType.magicPoints];
  get protectionIndex => _values[AttributeType.protectionIndex];
  get initiative => _values[AttributeType.initiative];
  get heroism => _values[AttributeType.heroism];
  get faith => _values[AttributeType.faith];

  get values => _values;

  final Map<AttributeType, Attribute> _values =
    AttributeType.values
      .where((t) => !_exceptions.contains(t))
      .map((t) => Attribute(t))
      .fold(Map<AttributeType, Attribute>(), (map, attribute) {
        map[attribute.type] = attribute;
        return map;
      });
}

class Equipments {
  Weapon leftHand;
  Weapon rightHand;
  Equipment _head;
  Equipment _armor;
  Equipment _boots;
  Equipment _ring;
  Equipment _amulet;

  get headgear => _head;
  get armor => _armor;
  get boots => _boots;
  get ring => _ring;
  get amulet => _amulet;

  set headgear(Equipment value) {
    if (value.type != EquipmentType.headgear) return;
    _head = value;
  }

  set armor(Equipment value) {
    if (value.type != EquipmentType.armor) return;
    _armor = value;
  }

  set boots(Equipment value) {
    if (value.type != EquipmentType.boots) return;
    _boots = value;
  }

  set ring(Equipment value) {
    if (value.type != EquipmentType.ring) return;
    _ring = value;
  }

  set amulet(Equipment value) {
    if (value.type != EquipmentType.amulet) return;
    _amulet = value;
  }
}
