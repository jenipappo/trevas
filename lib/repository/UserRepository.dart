import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trevas/model/User.dart';
import 'package:trevas/repository/Repository.dart';

class UserRepository extends Repository<User>{
  UserRepository() : super(Firestore.instance.collection("user"));
}

