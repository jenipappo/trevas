
class Character {

  String name;
  int wight;
  int height;
  DateTime birthday;
  String birthplace;
  Sex sex;
  String job;
  int age;
  int apparentAge;
  String religion;
  String lore;
  Attributes _attributes = Attributes();
  List<Skill> _skills = List();
  List<String> _languages = List();
  List<Power> _powers = List();
  List<Enhancement> _enhancements = List();

  Attributes get attributes => _attributes;
  List<Skill> get skills => _skills;
  List<String> get languages => _languages;
  List<Power> get powers => _powers;
  List<Enhancement> get enhancements => _enhancements;
}

enum Sex { male, female }

class Attribute {
  String alias;
  int base;
  int modifier;
  int get percentage => base * 4;

  Attribute(this.alias, [this.base, this.modifier]);
}


class StrengthAttribute extends Attribute {
  StrengthAttribute(String alias,[int base, int modifier]) : super(alias, base, modifier);

  set base(int base) {
    super.base = base;
    super.modifier = () {
      if (base < 15) return 0;
      return ((base - 15) / 2).floor();
    }();
  }
}


class Attributes {
  Attribute _constitution = Attribute("CON");
  Attribute _strength = Attribute("FOR");
  Attribute _dexterity = Attribute("DEX");
  Attribute _agility = Attribute("AGI");
  Attribute _intelligence = Attribute("INT");
  Attribute _willpower = Attribute("WILL");
  Attribute _perception = Attribute("PER");
  Attribute _charisma = Attribute("CAR");

  Attribute get constitution => _constitution;
  Attribute get strength => _strength;
  Attribute get dexterity => _dexterity;
  Attribute get agility => _agility;
  Attribute get intelligence => _intelligence;
  Attribute get willpower => _willpower;
  Attribute get perception => _perception;
  Attribute get charisma => _charisma;
}

class Skill {
  String name;
  Attribute attribute;
  int points;
  int get percentage => attribute?.base ?? 0 + points;

  Skill(this.name, this.attribute, this.points);
}

class Power {
  int _level;
  String _name;

  int get level => _level;
  String get name => _name;

  Power(this._name, this._level);
}

class Enhancement {
  int _level;
  String _name;

  int get level => _level;
  String get name => _name;

  Enhancement(this._name, this._level);
}