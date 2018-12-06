import 'package:firebase_database/firebase_database.dart';

class Team {
  String _id;
  String _coach;
  int _points;
  String _pointsReels;
  String _pointsVirtuels;
  String _poste;

  Team(this._id, this._coach, this._points, this._pointsReels, this._pointsVirtuels, this._poste);

  Team.map(dynamic obj) {
    this._id = obj['id'];
    this._coach = obj['coach'];
    this._points = obj['versus1'];
    this._pointsReels = obj['versus1'];
    this._pointsVirtuels = obj['versus1'];
    this._poste = obj['versus1'];
  }

  String get id => _id;
  String get coach => _coach;
  int get points => _points;
  String get pointsReels => _pointsReels;
  String get pointsVirtuels => _pointsVirtuels;
  String get poste => _poste;

  Team.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _coach = snapshot.value['coach'].toString();
    _poste = snapshot.value['versus1']['position'].toString();
    _points = snapshot.value['versus1']['points'] + snapshot.value['versus1']['pointsVirtuels'];
    _pointsReels = snapshot.value['versus1']['points'].toString();
    _pointsVirtuels = snapshot.value['versus1']['pointsVirtuels'].toString();

  }
}