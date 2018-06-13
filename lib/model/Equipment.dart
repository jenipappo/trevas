import 'package:trevas/model/AttributeBonus.dart';
import 'package:trevas/model/EquipmentType.dart';
import 'package:trevas/model/Item.dart';

class Equipment extends Item {
  final EquipmentType type;
  final List<AttributeBonus> bonuses;

  String name;

  Equipment(String id, this.name, this.type, this.bonuses) : super(id);
}