import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trevas/model/AttributeBonus.dart';
import 'package:trevas/model/DiceSet.dart';
import 'package:trevas/model/Equipment.dart';
import 'package:trevas/model/EquipmentType.dart';
import 'package:trevas/model/Game.dart';
import 'package:trevas/model/Model.dart';
import 'package:trevas/model/User.dart';
import 'package:trevas/model/Weapon.dart';
import 'package:trevas/model/WeaponType.dart';
import 'package:trevas/repository/serialization/Serializer.dart';

abstract class DocumentSerializer<T extends Model> implements Serializer<T> {

  // private constructor
  DocumentSerializer._initialize();

  // factory constructor
  factory DocumentSerializer() {
    if (T == Game) {
      return _GameSerializer() as DocumentSerializer<T>;
    } else if (T == User) {
      return _UserSerializer() as DocumentSerializer<T>;
    } else if (T == Weapon) {
      return _WeaponSerializer() as DocumentSerializer<T>;
    } else if (T == Equipment) {
      return _EquipmentSerializer() as DocumentSerializer<T>;
    } else {
      throw UnimplementedError("Serialization of this type is not yet implemented");
    }
  }

  // abstract methods
  T _deserialize(String id, Map<String, dynamic> data);
  Map<String, dynamic> _serialize(T model);

  T deserialize(Map<String, dynamic> data) {
    return _deserialize(data["id"], data);
  }

  T deserializeFromSnapshot(DocumentSnapshot snapshot) {
    return _deserialize(snapshot.documentID, snapshot.data);
  }

  Map<String, dynamic> serialize(T model) {
    return _serialize(model);
  }

  Map<String, dynamic>  serializeIncludingId(T model) {
    var map = _serialize(model);
    map["id"] = model.id;
    return map;
  }
}

class _GameSerializer extends DocumentSerializer<Game> {

  _GameSerializer() : super._initialize();

  @override
  Game _deserialize(String id, Map<String, dynamic> data) {

    var userSerializer = DocumentSerializer<User>();

    var name = data["name"];
    var description = data["description"];
    var master = userSerializer.deserialize(Map<String, dynamic>.from(data["master"]));
    var owner = userSerializer.deserialize(Map<String, dynamic>.from(data["owner"]));
    var playerCount = data["playerCount"] as int;
    var characterCount = data["playerCount"] as int;

    return Game(id, name, description, master, owner, playerCount, characterCount);
  }


  @override
  Map<String, dynamic>  _serialize(Game game) {
    return {
      "name": game.name,
      "description": game.description,
      "master": DocumentSerializer<User>().serializeIncludingId(game.master),
      "owner": DocumentSerializer<User>().serializeIncludingId(game.owner),
      "playerCount": game.playerCount,
      "characterCount": game.characterCount
    };
  }

}

class _UserSerializer extends DocumentSerializer<User> {

  _UserSerializer() : super._initialize();

  @override
  User _deserialize(String id, Map<String, dynamic> data) {
    var name = data["name"];
    var email = data["email"];

    return User(id, name, email);
  }

  @override
  Map<String, dynamic> _serialize(User user) {
    return {
      "name": user.name,
      "email": user.email
    };
  }

}

class _WeaponSerializer extends DocumentSerializer<Weapon> {

  _WeaponSerializer() : super._initialize();

  @override
  Weapon _deserialize(String id, Map<String, dynamic> data) {
    var attributeBonusSerializer = Serializer<AttributeBonus>();

    var name = data["name"];
    var bonuses = (data["bonuses"] as List<Map<String, dynamic>>).map((m) => attributeBonusSerializer.deserialize(m));
    var weaponType = WeaponType.values.singleWhere((e) => e.toString() == data["weaponType"]);
    var baseDamage = data["baseDamage"] as int;
    var dices = Serializer<DiceSet>().deserialize(data["dices"]);

    return Weapon(id, name, weaponType, baseDamage, dices, bonuses);
  }


  @override
  Map<String, dynamic> _serialize(Weapon weapon) {
    var attributeBonusSerializer = Serializer<AttributeBonus>();

    return {
      "name": weapon.name,
      "type": weapon.type.toString(),
      "bonuses": weapon.bonuses.map((b) => attributeBonusSerializer.serialize(b)),
      "weaponType": weapon.weaponType.toString(),
      "baseDamage": weapon.baseDamage.value,
      "dices":  Serializer<DiceSet>().serialize(weapon.dices)
    };
  }

}

class _EquipmentSerializer extends DocumentSerializer<Equipment> {

  _EquipmentSerializer() : super._initialize();

  @override
  Equipment _deserialize(String id, Map<String, dynamic> data) {
    var attributeBonusSerializer = Serializer<AttributeBonus>();

    var name = data["name"];
    var type = EquipmentType.values.singleWhere((e) => data["type"] == e.toString());
    var bonuses = (data["bonuses"] as List<Map<String, dynamic>>).map((m) => attributeBonusSerializer.deserialize(m));

    return Equipment(id, name, type, bonuses);
  }

  @override
  Map<String, dynamic> _serialize(Equipment vo) {
    var attributeBonusSerializer = Serializer<AttributeBonus>();

    return {
      "name": vo.name,
      "type": vo.type.toString(),
      "bonuses": vo.bonuses.map((b) => attributeBonusSerializer.serialize(b))
    };
  }

}