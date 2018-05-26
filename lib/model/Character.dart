import "dart:math";

class Character {

  Uri photo;
  int wight;
  int height;
  int age;
  int apparentAge;
  Sex sex;
  String name;
  String birthplace;
  String job;
  String religion;
  String lore;
  DateTime birthday;

  final Attributes attributes = Attributes();
  final Properties properties = Properties();
  final List<WeaponSkill> weaponSkills = List();
  final List<Skill> skills = List();
  final List<String> languages = List();
  final List<Power> powers = List();
  final List<Enhancement> enhancements = List();
}

enum Sex {
  male,
  female
}

enum AttributeType {
  constitution,
  strength,
  dexterity,
  agility,
  intelligence,
  willpower,
  perception,
  charisma
}

enum PropertyType {
  healthPoints,
  magicPoints,
  protectionIndex,
  initiative,
  heroism,
  faith
}

class Attribute {
  final AttributeType type;

  int base;
  int bonus;
  int modifier;

  Attribute(this.type, [this.base, this.modifier, this.bonus]);

  get percentage => base * 4;
  get current => base + bonus;
}

class Property {
  final PropertyType type;

  int base;
  int bonus;
  int _current;

  Property(this.type);

  get maximum => base + bonus;
  get current => _current;

  set current(value) {
    this._current = min(maximum, value);
  }
}

class _StrengthAttribute extends Attribute {
  _StrengthAttribute(AttributeType type,[int base, int modifier, int bonus]) : super(type, base, modifier, bonus);

  set base(int base) {
    super.base = base;
    super.modifier = () {
      if (base < 15) return 0;
      return ((base - 15) / 2).floor();
    }();
  }
}

class Attributes {
  final Attribute constitution = Attribute(AttributeType.constitution);
  final Attribute strength = _StrengthAttribute(AttributeType.strength);
  final Attribute dexterity = Attribute(AttributeType.dexterity);
  final Attribute agility = Attribute(AttributeType.agility);
  final Attribute intelligence = Attribute(AttributeType.intelligence);
  final Attribute willpower = Attribute(AttributeType.willpower);
  final Attribute perception = Attribute(AttributeType.perception);
  final Attribute charisma = Attribute(AttributeType.charisma);
}

class Properties {
  final Property healthPoints = Property(PropertyType.healthPoints);
  final Property magicPoints = Property(PropertyType.magicPoints);
  final Property protectionIndex = Property(PropertyType.protectionIndex);
  final Property initiative = Property(PropertyType.initiative);
  final Property heroism = Property(PropertyType.heroism);
  final Property faith = Property(PropertyType.faith);
}

class Skill {
  final String name;
  final Attribute attribute;

  int points;

  Skill(this.name, this.attribute, this.points);

  get percentage => attribute?.base ?? 0 + points;
}

class WeaponSkill {
  final Attributes _attributes;

  final String name;
  final int baseAttack;
  final int baseDefense;

  int bonusAttack;
  int bonusDefense;
  String damage;

  WeaponSkill(this.name, this.baseAttack, this.baseDefense, this._attributes);

  get attack => _attributes.dexterity.current + baseAttack + bonusAttack;
  get defense => _attributes.dexterity.current + baseDefense + bonusDefense;
}

class Power {
  final String name;

  int level;

  Power(this.name, this.level);
}

class Enhancement {
  final String name;

  int level;

  Enhancement(this.name, this.level);
}

