import 'package:trevas/model/AttributeBonus.dart';
import 'package:trevas/model/EquipmentType.dart';
import 'package:trevas/model/Item.dart';

class Equipment extends Item {
  final EquipmentType type;
  final List<AttributeBonus> bonuses = List();

  String name;

  Equipment(this.type);
}