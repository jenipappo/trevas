class User {
  String _id;
  String _name;
  String _email;
  String _username;

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get username => _username;

  User(this._id, this._name, this._email, this._username);

}