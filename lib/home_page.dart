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
        floatingActionButton: Align(
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              foregroundColor: Color.fromARGB(225, 236, 25, 10),
              tooltip: "Cevabı gör",
              elevation: 1,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          decoration: BoxDecoration(
                          color: Color.fromARGB(45, 248, 187, 208),
                          // borderRadius: BorderRadius.circular(50)
                          ) ,
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              context.read<PuzzleGame>().questionString,
                              style:  TextStyle(color: Colors.purple, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    });
              },
              child: const Icon(Icons.apple, size: 50,)),
        ),
        body: MediaQuery.removePadding(
          context: context,
          removeTop: false,
          child: Container(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              decoration: const BoxDecoration(
                gradient: RadialGradient(colors: [
                  Color.fromARGB(255, 174, 203, 226),
                  Color.fromARGB(255, 114, 168, 212)
                ],
                    // begin: const FractionalOffset(0.0, 0.0),
                    // end: const FractionalOffset(0.5, 0.0),
                    stops: [
                      0.0,
                      1.0
                    ], tileMode: TileMode.clamp),
                // image: DecorationImage(
                //     image: AssetImage('image/dikey.jpg'), fit: BoxFit.fitHeight)
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .8,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                        itemCount: context.read<PuzzleGame>().allString.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              context.read<PuzzleGame>().selectCell(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: context
                                            .watch<PuzzleGame>()
                                            .allCells[index]
                                            .isSelected
                                        ? 4
                                        : 1,
                                    color: context
                                            .watch<PuzzleGame>()
                                            .allCells[index]
                                            .isSelected
                                        ? Color.fromARGB(255, 199, 102, 64)
                                        : Colors.black),
                                color: context
                                        .watch<PuzzleGame>()
                                        .allCells[index]
                                        .isSelected
                                    ? Color.fromARGB(255, 230, 236, 134)
                                    : Colors.green.shade50,
                              ),
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
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.purple.shade700))),
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          '${context.read<PuzzleGame>().allCells[index].cellNumber}',
                                          style: const TextStyle(fontSize: 10),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.009,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(5)),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .18,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom),
                        child: Stack(
                          children: [
                            GridView.builder(
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 9),
                              itemCount:
                                  context.read<PuzzleGame>().alphabet.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      context
                                          .read<PuzzleGame>()
                                          .enterLetter(index);
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
                            // Align(
                            //     alignment: Alignment.centerRight,
                            //     child: Container(
                            //       margin: const EdgeInsets.all(5),
                            //       height: MediaQuery.of(context).size.height * 0.9,
                            //       width: MediaQuery.of(context).size.width * 0.2,
                            //       decoration:
                            //           BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5)),
                            //       child: const Center(
                            //           child: Text(
                            //         "Oyna",
                            //         style: TextStyle(color: Colors.white),
                            //       )),
                            //     )),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
}

/*class HomePage extends StatelessWidget {
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
}*/
