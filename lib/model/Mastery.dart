import 'package:trevas/model/AttributeType.dart';
import 'package:trevas/model/MasteryPonts.dart';

class Mastery {
  final String name;
  final AttributeType attributeType;
  final MasteryPoints points;

  Mastery(this.name, this.attributeType, this.points);
}

// TODO get percentage => attribute?.value ?? 0 + points.quantity;
