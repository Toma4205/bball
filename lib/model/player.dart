import 'package:firebase_database/firebase_database.dart';

class Player {
  String _id;
  String _title;
  String _description;
  String _duel;

  Player(this._id, this._title, this._description, this._duel);

  Player.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['playerName'];
    this._description = obj['points'];
    this._duel = obj['duel'];
  }

  String get id => _id;
  String get title => _title;
  String get description => _description;
  String get duel => _duel;

  Player.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _title = snapshot.key.toString();
    _description = snapshot.value['points'].toString();
    _duel = snapshot.value['duel'].toString();
  }
}