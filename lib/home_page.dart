import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_game/game_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final PuzzleGame game = context.read<PuzzleGame>();
    game.prepareGameString();
    return Scaffold(
        body: MediaQuery.removePadding(
      context: context,
      removeTop: false,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
          ),
          itemCount: game.allString.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                game.selectCell(index);
              },
              child: Container(
                color: context.watch<PuzzleGame>().allCells[index].isSelected
                    ? Colors.blueGrey
                    : Colors.amber,
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                            context
                                .watch<PuzzleGame>()
                                .allCells[index]
                                .userInput
                                .toUpperCase(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Text('${game.allCells[index].cellNumber}')),
                  ],
                ),
              ),
            );
          }),
    ));
  }
}
