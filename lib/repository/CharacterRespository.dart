import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trevas/model/Character.dart';
import 'package:trevas/repository/Repository.dart';

class CharacterRepository extends Repository<Character> {
  CharacterRepository() : super(Firestore.instance.collection("characters"));
}