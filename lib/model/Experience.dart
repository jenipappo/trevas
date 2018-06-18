class Experience {

  int _value;
  int _level;

  int get value => _value;
  int get level => _level;

  set value(int value) {
    _value = value;
    _level = _xpToLevel.lastIndexWhere((xp) => value >= xp) + 1;
  }

  List<int> _xpToLevel = [ 0, 5, 15, 30, 50, 80, 120, 180, 250, 400, 550, 800, 1100, 1600, 2200 ];
}