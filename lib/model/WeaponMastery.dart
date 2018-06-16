import 'package:trevas/model/MasteryPonts.dart';
import 'package:trevas/model/WeaponType.dart';

class WeaponMastery {
  final MasteryPoints attackPoints;
  final MasteryPoints defensePoints;
  final WeaponType weaponType;

  WeaponMastery(this.weaponType, this.attackPoints, this.defensePoints);
}

// TODO consolidate base attack and defense with bonuses
// get attack => _attribute.value + attackPoints.quantity;
// get defense => _attribute.value + defensePoints.quantity;

