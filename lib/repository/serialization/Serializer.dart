import 'package:trevas/model/Attribute.dart';
import 'package:trevas/model/AttributeBonus.dart';
import 'package:trevas/model/AttributeType.dart';
import 'package:trevas/model/DiceSet.dart';
import 'package:trevas/model/Enhancement.dart';
import 'package:trevas/model/Mastery.dart';
import 'package:trevas/model/MasteryPonts.dart';
import 'package:trevas/model/WeaponMastery.dart';
import 'package:trevas/model/WeaponType.dart';

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
    } else if (T == MasteryPoints) {
      return _MasteryPointsSerializer() as Serializer<T>;
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
    var masteryPointsSerializer = Serializer<MasteryPoints>();

    var weaponType = WeaponType.values.singleWhere((wt) => wt.toString() == data["weaponType"]);
    var attackPoints = masteryPointsSerializer.deserialize(Map<String, dynamic>.from(data["attackPoints"]));
    var defensePoints = masteryPointsSerializer.deserialize(Map<String, dynamic>.from(data["defencePoints"]));

    return WeaponMastery(weaponType, attackPoints, defensePoints);
  }

  @override
  Map<String, dynamic> serialize(WeaponMastery vo) {
    var masteryPointsSerializer = Serializer<MasteryPoints>();

    return {
      "weaponType": vo.weaponType.toString(),
      "attackPoints": masteryPointsSerializer.serialize(vo.attackPoints),
      "defencePoints": masteryPointsSerializer.serialize(vo.defensePoints)
    };
  }

}

class _MasterySerializer extends Serializer<Mastery> {

  _MasterySerializer() : super._initialize();

  @override
  Mastery deserialize(Map<String, dynamic> data) {
    var masteryPointsSerializer = Serializer<MasteryPoints>();

    var name = data["name"];
    var attributeType = AttributeType.values.singleWhere((at) => at.toString() == data["attributeType"]);
    var points = masteryPointsSerializer.deserialize(Map<String, dynamic>.from(data["points"]));

    return Mastery(name, attributeType, points);
  }

  @override
  Map<String, dynamic> serialize(Mastery vo) {
    var masteryPointsSerializer = Serializer<MasteryPoints>();

    return {
      "name": vo.name,
      "attributeType": vo.attributeType.toString(),
      "points": masteryPointsSerializer.serialize(vo.points)
    };
  }

}

class _EnhancementSerializer extends Serializer<Enhancement> {

  _EnhancementSerializer() : super._initialize();

  @override
  Enhancement deserialize(Map<String, dynamic> data) {
    var attributeBonusSerializer = Serializer<AttributeBonus>();

    var level = data["level"];
    var name = data["name"];
    var description = data["description"];

    var attributeBonusesRaw = List.from(data["attributeBonuses"]);
    var attributeBonuses = attributeBonusesRaw.map((data) => attributeBonusSerializer.deserialize(Map<String, dynamic>.from(data))).toList();

    return Enhancement(name, description, level, attributeBonuses);
  }

  @override
  Map<String, dynamic> serialize(Enhancement vo) {
    var attributeBonusSerializer = Serializer<AttributeBonus>();

    return {
      "level": vo.level,
      "name": vo.name,
      "description": vo.description,
      "attributeBonuses": vo.attributeBonuses.map((bonus) => attributeBonusSerializer.serialize(bonus)).toList()
    };
  }

}

class _MasteryPointsSerializer extends Serializer<MasteryPoints> {

  _MasteryPointsSerializer() : super._initialize();

  @override
  MasteryPoints deserialize(Map<String, dynamic> data) {
    var quantity = data["quantity"];
    return MasteryPoints(quantity);
  }

  @override
  Map<String, dynamic> serialize(MasteryPoints vo) {
    return {
      "quantity": vo.quantity,
    };
  }

}

