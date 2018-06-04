import 'package:trevas/model/Character.dart';
import 'package:trevas/model/WeaponKind.dart';


class WeaponMastery {
  final Attributes _attributes;

  final int baseAttack;
  final int baseDefense;
  final WeaponKind kind;

  WeaponMastery(this.kind, this.baseAttack, this.baseDefense, this._attributes);

  get attack => _attributes.dexterity.current + baseAttack;
  get defense => _attributes.dexterity.current + baseDefense;
}

// TODO consolidate base attack and defense with bonuses

