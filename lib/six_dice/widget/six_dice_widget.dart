import 'package:flutter/material.dart';
import 'package:six_dice/six_dice/game/widget_game.dart';
import 'package:six_dice/six_dice/player/widget_player/input_widget_player.dart';
import 'package:six_dice/six_dice/player/widget_player/widget_player.dart';
import 'package:six_dice/six_dice/widget/add_player_widget.dart';

class SixDiceWidget extends StatefulWidget {
  const SixDiceWidget({Key? key}) : super(key: key);

  @override
  State<SixDiceWidget> createState() => _SixDiceWidgetState();
}

class _SixDiceWidgetState extends State<SixDiceWidget> {
  final List<WidgetPlayer> players = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Six Dies'),
      ),
      body: Hero(
        tag: 'six_dice',
        child: Material(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Six Dice!',
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    final player = players[index];
                    var icon = Icons.computer;

                    if (player.runtimeType == InputWidgetPlayer) {
                      icon = Icons.person;
                    }

                    return ListTile(
                      leading: Icon(icon),
                      title: Text(player.name()),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            players.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (players.isNotEmpty) {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidgetGame(players),
                          ));
                      setState(() {
                        players.clear();
                      });
                    } else {
                      await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('No Players'),
                                content: const Text(
                                    'Please add at least one player!'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    }
                  },
                  child: const Text('Start Game!'),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push<WidgetPlayer>(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddPlayerWidget())).then((value) {
            if (value != null) {
              setState(() {
                players.add(value);
              });
            }
          });
        },
      ),
    );
  }
}
