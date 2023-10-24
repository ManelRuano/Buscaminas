import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class AppData with ChangeNotifier {
  // App status
  String dificultad = "facil";
  String bombs = "20";
  int dift = 0;
  bool shouldPlaceFlag = false;

  List<List<String>> board = [];

  bool gameIsOver = false;
  String gameWinner = '-';

  List<List<int>> bands = [];
  List<String> oldband = [];

  ui.Image? imagePlayer;
  ui.Image? imageOpponent;
  bool imagesReady = false;
  void tablero() {}

  void resetGame() {
    board = [
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
      [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'
      ],
    ];
    gameIsOver = false;
    gameWinner = '-';
    generateBombs();
    dif();
  }

  void dif() {
    switch (dificultad) {
      case "facil":
        dift = 9;
        break;
      case "dificil":
        dift = 15;
        break;
    }
  }

  void flag(int row, int col) {
    List<List<int>> bands = [];
    List<String> oldband = [];
    String post = board[row][col];
    List<int> band = [];
    band.add(row);
    band.add(col);
    oldband.add(post);
    bands.add(band);
    if (board[row][col] == 'F') {
      for (int i = 0; i < bands.length; i++) {
        if (oldband[i][0] == row && oldband[i][1] == col) {}
        board[row][col] = oldband[i];
      }
    } else {
      board[row][col] = 'F';
    }
  }

  void generateBombs() {
    dif();
    int numBombs = int.parse(bombs);
    Random random = Random();

    for (int i = 0; i < numBombs; i++) {
      int row, col;
      do {
        row = random.nextInt(dift);
        col = random.nextInt(dift);
      } while (board[row][col] == 'B');

      board[row][col] = 'B';
    }
  }

  void playMove(int row, int col) {
    if (board[row][col] == 'F') {
      flag(row, col);
      checkSurroundings(row, col);
    }
    if (board[row][col] == '-') {
      board[row][col] = 'O';
      checkSurroundings(row, col);
    }
    if (board[row][col] == 'B') {
      board[row][col] = 'X';
      gameIsOver = true;
      return;
    }

    checkGameWinner();
  }

  bool hasBombInSurroundings(int row, int col) {
    List<List<int>> directions = [
      [-1, 0],
      [1, 0],
      [0, -1],
      [0, 1],
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1]
    ];

    for (var direction in directions) {
      int newRow = row + direction[0];
      int newCol = col + direction[1];

      if (newRow >= 0 &&
          newRow < board.length &&
          newCol >= 0 &&
          newCol < board[newRow].length) {
        if (board[newRow][newCol] == 'B') {
          return true;
        }
      }
    }

    return false;
  }

  void checkSurroundings(int row, int col) {
    List<List<int>> directions = [
      [-1, -1],
      [-1, 0],
      [-1, 1],
      [0, -1],
      [0, 1],
      [1, -1],
      [1, 0],
      [1, 1]
    ];

    int bombCount = 0;

    for (var direction in directions) {
      int newRow = row + direction[0];
      int newCol = col + direction[1];

      if (newRow >= 0 &&
          newRow < board.length &&
          newCol >= 0 &&
          newCol < board[newRow].length) {
        String cellValue = board[newRow][newCol];
        if (cellValue == 'B') {
          bombCount++;
        }
      }
    }

    if (bombCount > 0) {
      // Si hay bombas cercanas, coloca el número de bombas en lugar de "O"
      board[row][col] = bombCount.toString();
    } else {
      board[row][col] = '0';

      for (var direction in directions) {
        int newRow = row + direction[0];
        int newCol = col + direction[1];

        // Verifica si las nuevas coordenadas están dentro de los límites del tablero
        if (newRow >= 0 &&
            newRow < board.length &&
            newCol >= 0 &&
            newCol < board[newRow].length) {
          String cellValue = board[newRow][newCol];
          if (cellValue == '-') {
            checkSurroundings(newRow, newCol);
          }
        }
      }
    }
  }

  void checkGameWinner() {
    bool allCellsRevealed = true;

    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        if (board[i][j] != 'B' && board[i][j] != 'X') {
          // Si una casilla no es una bomba y no ha sido revelada, el juego no ha terminado
          if (board[i][j] == '-') {
            allCellsRevealed = false;
            break;
          }
        }
      }
      if (!allCellsRevealed) {
        break;
      }
    }

    if (allCellsRevealed) {
      gameIsOver = true;
    }
  }

  Future<void> loadImages(BuildContext context) async {
    if (imagesReady) {
      notifyListeners();
      return;
    }

    // Força simular un loading
    await Future.delayed(const Duration(milliseconds: 500));

    Image tmpPlayer = Image.asset('assets/images/player.png');
    Image tmpOpponent = Image.asset('assets/images/opponent.png');

    // Carrega les imatges
    if (context.mounted) {
      imagePlayer = await convertWidgetToUiImage(tmpPlayer);
    }
    if (context.mounted) {
      imageOpponent = await convertWidgetToUiImage(tmpOpponent);
    }

    imagesReady = true;

    // Notifica als escoltadors que les imatges estan carregades
    notifyListeners();
  }

  // Converteix les imatges al format vàlid pel Canvas
  Future<ui.Image> convertWidgetToUiImage(Image image) async {
    final completer = Completer<ui.Image>();
    image.image.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (info, _) => completer.complete(info.image),
          ),
        );
    return completer.future;
  }
}
