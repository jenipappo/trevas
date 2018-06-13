import 'package:trevas/model/Attribute.dart';
import 'package:trevas/model/AttributeBonus.dart';
import 'package:trevas/model/AttributeType.dart';
import 'package:trevas/model/DiceSet.dart';

abstract class Serializer<T> {

  // private constructor
  Serializer._initialize();

  // factory constructor
  factory Serializer() {
    if (T == Attribute) {
      return _AttributeSerializer() as Serializer<T>;
    } else if (T == AttributeBonus) {
      return _AttributeBonusSerializer() as Serializer<T>;
    } else if (T == DiceSet) {
      return _DiceSetSerializer() as Serializer<T>;
    } else {
      throw UnimplementedError("Serialization of this type is not yet implemented");
    }
  }

  // abstract methods
  T deserialize(Map<String, dynamic> data);
  Map<String, dynamic> serialize(T vo);
}

class _AttributeSerializer extends Serializer<Attribute> {

  _AttributeSerializer() : super._initialize();

  @override
  Attribute deserialize(Map<String, dynamic> data) {
    var type = AttributeType.values.singleWhere((t) => t.toString() == data["type"]);
    var value = data["value"];

    return Attribute(type, value);
  }

  @override
  Map<String, dynamic> serialize(Attribute attribute) {
    return {
      "type": attribute.type.toString(),
      "value": attribute.value
    };
  }

}

class _AttributeBonusSerializer extends Serializer<AttributeBonus> {

  _AttributeBonusSerializer() : super._initialize();

  @override
  AttributeBonus deserialize(Map<String, dynamic> data) {
    var type = AttributeType.values.singleWhere((t) => t.toString() == data["type"]);
    var value = data["value"];

    return AttributeBonus(type, value);
  }

  @override
  Map<String, dynamic> serialize(AttributeBonus attributeBonus) {
    return {
      "type": attributeBonus.attributeType.toString(),
      "value": attributeBonus.value
    };
  }

}

class _DiceSetSerializer extends Serializer<DiceSet> {

  _DiceSetSerializer() : super._initialize();

  @override
  DiceSet deserialize(Map<String, dynamic> data) {
    int sides = data["sides"];
    int quantity = data["quantity"];

    return DiceSet(quantity, sides);
  }

  @override
  Map<String, dynamic> serialize(DiceSet diceSet) {
    return {
      "quantity": diceSet.quantity,
      "sides": diceSet.sides
    };
  }

}