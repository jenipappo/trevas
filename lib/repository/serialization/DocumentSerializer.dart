import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trevas/model/Attribute.dart';
import 'package:trevas/model/AttributeBonus.dart';
import 'package:trevas/model/Character.dart';
import 'package:trevas/model/DiceSet.dart';
import 'package:trevas/model/Enhancement.dart';
import 'package:trevas/model/Equipment.dart';
import 'package:trevas/model/EquipmentType.dart';
import 'package:trevas/model/Game.dart';
import 'package:trevas/model/Gender.dart';
import 'package:trevas/model/Mastery.dart';
import 'package:trevas/model/Model.dart';
import 'package:trevas/model/User.dart';
import 'package:trevas/model/Weapon.dart';
import 'package:trevas/model/WeaponMastery.dart';
import 'package:trevas/model/WeaponType.dart';
import 'package:trevas/repository/serialization/Serializer.dart';

abstract class DocumentSerializer<T extends Model> implements Serializer<T> {

  // private constructor
  DocumentSerializer._initialize();

  // factory constructor
  factory DocumentSerializer() {
    if (T == Character) {
      return _CharacterSerializer() as DocumentSerializer<T>;
    } else if (T == Game) {
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

class _CharacterSerializer extends DocumentSerializer<Character> {

  _CharacterSerializer() : super._initialize();

  @override
  Character _deserialize(String id, Map<String, dynamic> data) {
    var character = Character(id);

    // information
    character.photo = Uri.parse(data["photo"]);
    character.weight = data["weight"];
    character.height = data["height"];
    character.age = data["age"];
    character.apparentAge = data["apparentAge"];
    character.resources = data["resources"];
    character.gender = Gender.values.singleWhere((g) => g.toString() == data["gender"]);
    character.name = data["name"];
    character.birthplace = data["birthplace"];
    character.job = data["job"];
    character.religion = data["religion"];
    character.lore = data["lore"];
    character.birthday = DateTime.parse(data["birthday"]);
    character.languages.addAll(data["languages"]);
    character.experience.value = data["experience"];

    // weapons
    var weaponSerializer = DocumentSerializer<Weapon>();
    character.equipments.leftHand = weaponSerializer.deserialize(data["equipments"]["leftHand"]);
    character.equipments.rightHand = weaponSerializer.deserialize(data["equipments"]["rightHand"]);

    // equipments
    var equipmentSerializer = DocumentSerializer<Equipment>();
    character.equipments.headgear = equipmentSerializer.deserialize(data["equipments"]["headgear"]);
    character.equipments.armor = equipmentSerializer.deserialize(data["equipments"]["armor"]);
    character.equipments.boots = equipmentSerializer.deserialize(data["equipments"]["boots"]);
    character.equipments.ring = equipmentSerializer.deserialize(data["equipments"]["ring"]);
    character.equipments.amulet = equipmentSerializer.deserialize(data["equipments"]["amulet"]);

    // attributes
    var attributeSerializer = Serializer<Attribute>();
    var attributesRaw = data["attributes"] as List<Map<String, dynamic>>;
    var attributes = attributesRaw.map((a) => attributeSerializer.deserialize(a));
    character.attributes.copyValuesFrom(attributes);

    // weapon masteries
    var weaponMasterySerializer = Serializer<WeaponMastery>();
    var weaponMasteriesRaw = data["weaponMasteries"] as List<Map<String, dynamic>>;
    var weaponMasteries = weaponMasteriesRaw.map((e) => weaponMasterySerializer.deserialize(e));
    character.weaponMasteries.addAll(weaponMasteries);

    // masteries
    var masterySerializer = Serializer<Mastery>();
    var masteriesRaw = data["masteries"] as List<Map<String, dynamic>>;
    var masteries = masteriesRaw.map((e) => masterySerializer.deserialize(e));
    character.masteries.addAll(masteries);

    // enhancements
    var enhancementSerializer = Serializer<Enhancement>();

    // powers
    var powersRaw = data["powers"] as List<Map<String, dynamic>>;
    var powers = powersRaw.map((e) => enhancementSerializer.deserialize(e));
    character.powers.addAll(powers);

    // improvements
    var improvementsRaw = data["improvements"] as List<Map<String, dynamic>>;
    var improvements = improvementsRaw.map((e) => enhancementSerializer.deserialize(e));
    character.improvements.addAll(improvements);

    return character;
  }

  @override
  Map<String, dynamic> _serialize(Character model) {

    var weaponSerializer = DocumentSerializer<Weapon>();
    var equipmentSerializer = DocumentSerializer<Equipment>();
    var attributeSerializer = Serializer<Attribute>();
    var weaponMasterySerializer = Serializer<WeaponMastery>();
    var masterySerializer = Serializer<Mastery>();
    var enhancementSerializer = Serializer<Enhancement>();

    return {
      "photo": model.photo.path,
      "weight": model.weight,
      "height": model.height,
      "age": model.age,
      "apparentAge": model.apparentAge,
      "resources": model.resources,
      "gender": model.gender.toString(),
      "name": model.name,
      "birthplace": model.birthplace,
      "job": model.job,
      "religion": model.religion,
      "lore": model.lore,
      "birthday": model.birthday.toIso8601String(),
      "languages": model.languages,
      "experience": model.experience.value,
      // equipments
      "equipments": {
        "leftHand": weaponSerializer.serialize(model.equipments.leftHand),
        "rightHand": weaponSerializer.serialize(model.equipments.rightHand),
        "headgear": equipmentSerializer.serialize(model.equipments.headgear),
        "armor": equipmentSerializer.serialize(model.equipments.armor),
        "boots": equipmentSerializer.serialize(model.equipments.boots),
        "ring": equipmentSerializer.serialize(model.equipments.ring),
        "amulet": equipmentSerializer.serialize(model.equipments.amulet),
      },
      // attributes
      "attributes": model.attributes.values.values.map((attr) => attributeSerializer.serialize(attr)),
      // weapon masteries
      "weaponMasteries": model.weaponMasteries.map((wm) => weaponMasterySerializer.serialize(wm)),
      // masteries
      "masteries": model.masteries.map((m) => masterySerializer.serialize(m)),
      // powers
      "powers": model.powers.map((p) => enhancementSerializer.serialize(p)),
      // improvements
      "improvements": model.improvements.map((p) => enhancementSerializer.serialize(p)),
    };
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