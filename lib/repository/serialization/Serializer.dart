import 'package:trevas/model/Attribute.dart';
import 'package:trevas/model/AttributeBonus.dart';
import 'package:trevas/model/AttributeType.dart';
import 'package:trevas/model/DiceSet.dart';
import 'package:trevas/model/Enhancement.dart';
import 'package:trevas/model/Mastery.dart';
import 'package:trevas/model/WeaponMastery.dart';

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
    } else if (T == Mastery) {
      return _MasterySerializer() as Serializer<T>;
    } else if (T == WeaponMastery) {
      return _WeaponMasterySerializer() as Serializer<T>;
    } else if (T == Enhancement) {
      return _EnhancementSerializer() as Serializer<T>;
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

class _WeaponMasterySerializer extends Serializer<WeaponMastery> {

  _WeaponMasterySerializer() : super._initialize();

  @override
  WeaponMastery deserialize(Map<String, dynamic> data) {
    // TODO: implement deserialize
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> serialize(WeaponMastery vo) {
    // TODO: implement serialize
    throw UnimplementedError();
  }

}

class _MasterySerializer extends Serializer<Mastery> {

  _MasterySerializer() : super._initialize();

  @override
  Mastery deserialize(Map<String, dynamic> data) {
    // TODO: implement deserialize
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> serialize(Mastery vo) {
    // TODO: implement serialize
    throw UnimplementedError();
  }

}

class _EnhancementSerializer extends Serializer<Enhancement> {

  _EnhancementSerializer() : super._initialize();

  @override
  Enhancement deserialize(Map<String, dynamic> data) {
    // TODO: implement deserialize
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> serialize(Enhancement vo) {
    // TODO: implement serialize
    throw UnimplementedError();
  }

}