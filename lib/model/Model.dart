abstract class Model {
  final String id;

  Model(this.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Model &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

}