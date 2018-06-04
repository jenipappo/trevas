import 'package:trevas/model/Equipment.dart';
import 'package:trevas/model/EquipmentType.dart';
import 'package:trevas/model/WeaponKind.dart';

class Weapon extends Equipment {

  final String name;
  final WeaponKind kind;
  final Damage damage;
  final int bonusAttack;
  final int bonusDefense;

  Weapon(this.name, this.kind, this.damage, this.bonusAttack, this.bonusDefense) : super(EquipmentType.weapon);
}

/// Class representing an weapon damage
class Damage {
  /// Base damage
  int base;
  /// Number of dices
  int diceQuantity;
  /// Size of the dice i.e. 6 if D6, 10 if D10, etc.
  int diceSize;
}