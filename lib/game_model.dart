import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:puzzle_game/constants.dart';

class PuzzleGame with ChangeNotifier {
  final String questionString =
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";
  late String removeSpaceAndSpecialChars;
  late List<String> allString;
  late Set<String> allStringsOne;
  late Set<int> allNumbersOne;
  late List<GameCell> allCells;
  late List<String> alphabet = Constants.alphabet;
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
          cellType: CellType.changable);
    }).toList();

    int answerLength = (allString.length * .07).toInt();

    for (var i = 0; i < answerLength; i++) {
      var cell = allCells[i];
      allCells.forEach((element) {
        if (element.cellNumber == cell.cellNumber) {
          element.updateAnswer(element.cellAnswer);
          element.cellType = CellType.fix;
        }
      });
      alphabet.remove(cell.cellAnswer);
    }
  }

  void selectCell(int selectedIndex) {
    if (allCells[selectedIndex].cellType == CellType.fix) return;
    if (isAnyCellNotSelected || allCells[selectedIndex].isSelected) {
      allCells[selectedIndex].updateSelecState();
    }
    isAnyCellNotSelected =
        !allCells.any((element) => element.isSelected == true);
    notifyListeners();
  }

  void enterLetter(int selectedIndex) {
    if (!allCells.any((element) => element.isSelected == true)) return;
    var selectedCell =
        allCells.firstWhere((element) => element.isSelected == true);
    allCells.forEach((element) {
      if (element.cellNumber == selectedCell.cellNumber) {
        element.updateAnswer(alphabet[selectedIndex]);
      }
    });
    selectedCell.updateSelecState();
    notifyListeners();
  }
}

class GameCell {
  final String cellAnswer;
  String userInput = '';
  final int cellNumber;
  bool isCorrect = false;
  bool isSelected = false;
  CellType cellType;

  GameCell({
    required this.cellAnswer,
    required this.cellNumber,
    required this.cellType,
  });

  void updateAnswer(String input) {
    userInput = input;
    isCorrect = cellAnswer == userInput;
  }

  void updateSelecState() => isSelected = !isSelected;
}

enum CellType { changable, fix }
