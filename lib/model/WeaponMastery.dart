import 'package:trevas/model/Character.dart';


class WeaponMastery {
  final Attributes _attributes;

  final String name;
  final int baseAttack;
  final int baseDefense;

  WeaponMastery(this.name, this.baseAttack, this.baseDefense, this._attributes);

  get attack => _attributes.dexterity.current + baseAttack;
  get defense => _attributes.dexterity.current + baseDefense;
}

// TODO consolidate base attack and defense with bonuses

