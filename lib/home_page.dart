import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_game/game_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final PuzzleGame game = context.read<PuzzleGame>();
    context.read<PuzzleGame>().prepareGameString();
    return Scaffold(
        body: MediaQuery.removePadding(
      context: context,
      removeTop: false,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .8,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemCount: context.read<PuzzleGame>().allString.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      context.read<PuzzleGame>().selectCell(index);
                    },
                    child: Container(
                      color:
                          context.watch<PuzzleGame>().allCells[index].isSelected
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
                              child: Text(
                                  '${context.read<PuzzleGame>().allCells[index].cellNumber}')),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .18,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: context.read<PuzzleGame>().alphabet.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        context.read<PuzzleGame>().enterLetter(index);
                      },
                      child: Card(
                          child: Center(
                              child: Text(
                                  context
                                      .watch<PuzzleGame>()
                                      .alphabet[index]
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)))));
                },
              ),
            ),
          )
        ],
      ),
    ));
  }
}
