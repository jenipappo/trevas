import 'package:trevas/model/Attribute.dart';
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

  Weapon(this.name, this.weaponType, int baseDamage, this.dices) : super(EquipmentType.weapon) {
    this.baseDamage.value = baseDamage;
  }
}