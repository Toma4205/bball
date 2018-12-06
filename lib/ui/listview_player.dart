import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'package:the_gorgeous_login/model/player.dart';
import 'package:the_gorgeous_login/ui/listview_team.dart';
//import 'package:bballapp/ui/player_screen.dart';

class ListViewPlayer extends StatefulWidget {
  @override
  _ListViewPlayerState createState() => new _ListViewPlayerState();
}

final leaguesReference = FirebaseDatabase.instance.reference().child('leagues/league1/schedule/versus1');

class _ListViewPlayerState extends State<ListViewPlayer> {
  List<Player> items;
  StreamSubscription<Event> _onPlayerAddedSubscription;
  StreamSubscription<Event> _onPlayerChangedSubscription;

  @override
  void initState() {
    super.initState();

    items = new List();

    _onPlayerAddedSubscription = leaguesReference.onChildAdded.listen(_onPlayerAdded);
    _onPlayerChangedSubscription = leaguesReference.onChildChanged.listen(_onPlayerUpdated);
  }

  @override
  void dispose() {
    _onPlayerAddedSubscription.cancel();
    _onPlayerChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BBall Super App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('BBall Super App'),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        'coach : '+'${items[position].title}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Text(
                        '${items[position].description}'+' points dont '+'${items[position].duel}'+' sur les duels',
                        style: new TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      leading: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10.0)),
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 15.0,
                            child: Text(
                              '${position + 1}',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => null),
                        ],
                      ),
                      onTap: () => _navigateToPlayer(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => null,
        ),
      ),
    );
  }

  void _onPlayerAdded(Event event) {
    setState(() {
      items.add(new Player.fromSnapshot(event.snapshot));
    });
  }

  void _onPlayerUpdated(Event event) {
    var oldPlayerValue = items.singleWhere((player) => player.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldPlayerValue)] = new Player.fromSnapshot(event.snapshot);
    });
  }


  void _navigateToPlayer(BuildContext context, Player player) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListViewTeam(player)),
    );
  }
}