import 'package:trevas/model/Attribute.dart';
import 'package:trevas/model/AttributeType.dart';
import 'package:trevas/model/MasteryPonts.dart';
import 'package:trevas/model/WeaponType.dart';


class WeaponMastery {
  final Attribute _attribute;

  final MasteryPoints attackPoints;
  final MasteryPoints defensePoints;
  final WeaponType weaponType;

  WeaponMastery(this.weaponType, this.attackPoints, this.defensePoints, this._attribute) {
    if (_attribute.type != AttributeType.dexterity) {
      throw ArgumentError("Attribute: must be of dexterity tpe");
    }
  }

  get attack => _attribute.value + attackPoints.quantity;
  get defense => _attribute.value + defensePoints.quantity;
}

// TODO consolidate base attack and defense with bonuses

