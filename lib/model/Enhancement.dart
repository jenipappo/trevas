import 'package:trevas/model/AttributeBonus.dart';

class Enhancement {
  final List<AttributeBonus> attributeBonuses;

  int level;
  String name;
  String description;

  Enhancement(this.name, this.description, this.level, this.attributeBonuses);
}
