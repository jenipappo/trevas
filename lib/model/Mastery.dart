import 'package:trevas/model/Attribute.dart';
import 'package:trevas/model/MasteryPonts.dart';

class Mastery {
  final String name;
  final Attribute attribute;

  MasteryPoints points;

  Mastery(this.name, this.attribute, this.points);

  get percentage => attribute?.value ?? 0 + points.quantity;
}
