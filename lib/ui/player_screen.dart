import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:bballapp/model/player.dart';

class PlayerScreen extends StatefulWidget {
final Player player;
PlayerScreen(this.player);

@override
State<StatefulWidget> createState() => new _PlayerScreenState();
}

final leaguesReference = FirebaseDatabase.instance.reference().child('leagues/league1/schedule/versus1');

class _PlayerScreenState extends State<PlayerScreen> {
TextEditingController _titleController;
TextEditingController _descriptionController;
TextEditingController _duelController;

@override
void initState() {
super.initState();

_titleController = new TextEditingController(text: widget.player.title);
_descriptionController = new TextEditingController(text: widget.player.description);
_duelController = new TextEditingController(text: widget.player.duel);

}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Player')),
    body: Container(
      margin: EdgeInsets.all(15.0),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          Padding(padding: new EdgeInsets.all(5.0)),
          TextField(
          controller: _descriptionController,
          decoration: InputDecoration(labelText: 'Description'),
          ),
          Padding(padding: new EdgeInsets.all(5.0)),
          RaisedButton(
            child: (widget.player.id != null) ? Text('Update') : Text('Add'),
            onPressed: () {
              if (widget.player.id != null) {
                leaguesReference.child(widget.player.id).set({
                  'title': _titleController.text,
                  'description': _descriptionController.text
                }).then((_) {
                  Navigator.pop(context);
                });
              } else {
                leaguesReference.push().set({
                  'title': _titleController.text,
                  'description': _descriptionController.text
                }).then((_) {
                  Navigator.pop(context);
                });
              }
            },
          ),
        ],
      ),
    ),
  );
}
}