import 'package:trevas/model/AttributeBonus.dart';

class Enhancement {
  final String name;
  final String description;
  final List<AttributeBonus> bonuses = List();

  int level;

  Enhancement(this.name, this.description, this.level);
}
