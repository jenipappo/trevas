import 'package:trevas/model/Attribute.dart';
import 'package:trevas/model/AttributeBonus.dart';
import 'package:trevas/model/AttributeType.dart';
import 'package:trevas/model/DiceSet.dart';
import 'package:trevas/model/Equipment.dart';
import 'package:trevas/model/EquipmentType.dart';
import 'package:trevas/model/WeaponType.dart';

class Weapon extends Equipment {

  final String name;
  final WeaponType weaponType;
  final Attribute baseDamage = Attribute(AttributeType.damage);
  final DiceSet dices;

  Weapon(String id, this.name, this.weaponType, int baseDamage, this.dices, List<AttributeBonus> bonuses) : super(id, name, EquipmentType.weapon, bonuses) {
    this.baseDamage.value = baseDamage;
  }
}