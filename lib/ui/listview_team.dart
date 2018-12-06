import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'package:the_gorgeous_login/model/team.dart';
import 'package:the_gorgeous_login/model/player.dart';

class ListViewTeam extends StatefulWidget {
  final Player player;
  ListViewTeam(this.player);

  @override
  _ListViewTeamState createState() => new _ListViewTeamState();
}

final teamReference = FirebaseDatabase.instance.reference().child('leagues/league1/players');


class _ListViewTeamState extends State<ListViewTeam> {
  List<Team> items;
  StreamSubscription<Event> _onTeamAddedSubscription;
  StreamSubscription<Event> _onTeamChangedSubscription;

  @override
  void initState() {
    super.initState();

    items = new List();
    _onTeamAddedSubscription = teamReference.onChildAdded.listen(_onTeamAdded);
    _onTeamChangedSubscription = teamReference.onChildChanged.listen(_onTeamUpdated);
  }

  @override
  void dispose() {
    _onTeamAddedSubscription.cancel();
    _onTeamChangedSubscription.cancel();
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
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[position].id}' + ' : ' + '${items[position].points}' + ' pts',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Text(
                        '${items[position].pointsReels}' + ' pts réels, ' +
                            '${items[position].pointsVirtuels}' +
                            ' pts virtuels',
                        style: new TextStyle(
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      leading: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10.0)),
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 19.0,
                            child: Text(
                              '${items[position].poste}',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      onTap: () =>
                          _navigateToPlayer(context, items[position]),
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

  void _onTeamAdded(Event event) {
    setState(() {
      items.add(new Team.fromSnapshot(event.snapshot));
    });
  }

  void _onTeamUpdated(Event event) {
    var oldTeamValue = items.singleWhere((team) => team.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldTeamValue)] = new Team.fromSnapshot(event.snapshot);
    });
  }


  void _navigateToPlayer(BuildContext context, Team team) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => null), //TeamScreen(team)),
    );
  }
}