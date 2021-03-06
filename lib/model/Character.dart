import 'package:trevas/model/Attribute.dart';
import 'package:trevas/model/AttributeType.dart';
import 'package:trevas/model/Enhancement.dart';
import 'package:trevas/model/Equipment.dart';
import 'package:trevas/model/EquipmentType.dart';
import 'package:trevas/model/Experience.dart';
import 'package:trevas/model/Gender.dart';
import 'package:trevas/model/Mastery.dart';
import 'package:trevas/model/Model.dart';
import 'package:trevas/model/Weapon.dart';
import 'package:trevas/model/WeaponMastery.dart';

class Character extends Model {

  /// Character photo URL.
  Uri photo;
  /// Character weight.
  int weight;
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

  Character(String id) : super(id);
}

class Attributes {

  static const _availableAttributes = [
    AttributeType.constitution,
    AttributeType.strength,
    AttributeType.dexterity,
    AttributeType.agility,
    AttributeType.intelligence,
    AttributeType.willpower,
    AttributeType.perception,
    AttributeType.charisma,
    AttributeType.healthPoints,
    AttributeType.magicPoints,
    AttributeType.protectionIndex,
    AttributeType.initiative,
    AttributeType.heroism,
    AttributeType.faith,
  ];

  Attribute get constitution => _values[AttributeType.constitution];
  Attribute get strength => _values[AttributeType.strength];
  Attribute get dexterity => _values[AttributeType.dexterity];
  Attribute get agility => _values[AttributeType.agility];
  Attribute get intelligence => _values[AttributeType.intelligence];
  Attribute get willpower => _values[AttributeType.willpower];
  Attribute get perception => _values[AttributeType.perception];
  Attribute get charisma => _values[AttributeType.charisma];
  Attribute get healthPoints => _values[AttributeType.healthPoints];
  Attribute get magicPoints => _values[AttributeType.magicPoints];
  Attribute get protectionIndex => _values[AttributeType.protectionIndex];
  Attribute get initiative => _values[AttributeType.initiative];
  Attribute get heroism => _values[AttributeType.heroism];
  Attribute get faith => _values[AttributeType.faith];
  Attribute get baseDamage => _StrengthDerivedBaseDamage(this.strength);

  Map<AttributeType, Attribute> get values => _values;

  final Map<AttributeType, Attribute> _values = Map();

  Attributes() {
    _availableAttributes.forEach((t) => _values[t] = Attribute(t));
  }

  void copyValuesFrom(List<Attribute> attributes) {
    attributes.forEach((a) {
      var attribute = _values[a.type];
      if (attribute != null) {
        attribute.value = a.value;
      }
    });
  }
}

class Equipments {
  Weapon leftHand;
  Weapon rightHand;
  Equipment _headgear;
  Equipment _armor;
  Equipment _boots;
  Equipment _ring;
  Equipment _amulet;

  Equipment get headgear => _headgear;
  Equipment get armor => _armor;
  Equipment get boots => _boots;
  Equipment get ring => _ring;
  Equipment get amulet => _amulet;

  set headgear(Equipment value) {
    if (value != null && value.type != EquipmentType.headgear) return;
    _headgear = value;
  }

  set armor(Equipment value) {
    if (value != null && value.type != EquipmentType.armor) return;
    _armor = value;
  }

  set boots(Equipment value) {
    if (value != null && value.type != EquipmentType.boots) return;
    _boots = value;
  }

  set ring(Equipment value) {
    if (value != null && value.type != EquipmentType.ring) return;
    _ring = value;
  }

  set amulet(Equipment value) {
    if (value != null && value.type != EquipmentType.amulet) return;
    _amulet = value;
  }
}

class _StrengthDerivedBaseDamage extends Attribute {

  Attribute _strengthAttribute;

  @override
  get value {
    if (_strengthAttribute.value < 15) return 0;
    return ((_strengthAttribute.value - 13) / 2).floor();
  }

  @override
  set value(int value) {
    // ignore, base damage value can't be set
  }

  _StrengthDerivedBaseDamage(this._strengthAttribute) : super(AttributeType.damage) {
    if (_strengthAttribute.type != AttributeType.strength) {
      throw new ArgumentError("BaseDamageAttribute: need the strenght attribute to calculate base damange");
    }
  }
}