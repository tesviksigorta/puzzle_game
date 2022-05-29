import 'dart:math';

import 'package:flutter/foundation.dart';

class PuzzleGame with ChangeNotifier{
  final String questionString =
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";
  late String removeSpaceAndSpecialChars;
  late List<String> allString;
  late Set<String> allStringsOne;
  late Set<int> allNumbersOne;
  late List<GameCell> allCells;
  bool isAnyCellNotSelected = true;
  void prepareGameString() {
    removeSpaceAndSpecialChars = questionString
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .replaceAll(' ', '')
        .toLowerCase();
    allString = removeSpaceAndSpecialChars.split('');
    allStringsOne = Set.from(allString);
    allNumbersOne = {};
    while (allNumbersOne.length != allStringsOne.length) {
      var randomInt = Random().nextInt(allStringsOne.length + 10);

      allNumbersOne.add(randomInt + 1);
    }
    allCells = allString.map((e) {
      var index = allStringsOne.toList().indexOf(e);
      return GameCell(
        cellNumber: allNumbersOne.elementAt(index),
        cellAnswer: e,
      );
    }).toList();

    int answerLength = (allString.length * .07).toInt();

    for (var i = 0; i < answerLength; i++) {
      var cell = allCells[i];
      allCells.forEach((element) {
        if (element.cellNumber == cell.cellNumber) {
          element.updateAnswer(element.cellAnswer);
        }
      });
    }
    notifyListeners();
  }

  void selectCell(int selectedIndex){
    if(isAnyCellNotSelected || allCells[selectedIndex].isSelected)
      {
      allCells[selectedIndex].updateSelecState();
    }
    isAnyCellNotSelected = !allCells.any((element) => element.isSelected == true);
    notifyListeners();
  }
}

class GameCell {
  final String cellAnswer;
  String userInput = '';
  final int cellNumber;
  bool isCorrect = false;
  bool isSelected = false;

  GameCell({required this.cellAnswer, required this.cellNumber});

  void updateAnswer(String input) {
    userInput = input;
    isCorrect = cellAnswer == userInput;
  
  }

  void updateSelecState() => isSelected = !isSelected;


}
