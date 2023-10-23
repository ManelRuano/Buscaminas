import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class AppData with ChangeNotifier {
  // App status
  String colorPlayer = "Verd";
  String colorOpponent = "Taronja";
  String dificultad = "facil";
  String bombs = "20";
  int dift = 0;

  List<List<String>> board = [];
  bool gameIsOver = false;
  String gameWinner = '-';

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

  void generateBombs() {
    dif();
    int numBombs = int.parse(bombs);
    Random random = Random();

    for (int i = 0; i < numBombs; i++) {
      int row, col;
      do {
        // Genera coordenadas aleatorias para colocar la bomba
        row = random.nextInt(dift);
        col = random.nextInt(dift);
      } while (board[row][col] ==
          'B'); // Asegúrate de que no coloques una bomba en una celda ocupada

      board[row][col] = 'B'; // Coloca la bomba en la celda
    }
  }

  // Fa una jugada, primer el jugador després la maquina
  void playMove(int row, int col) {
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
          return true; // Si hay una bomba en las celdas circundantes, devuelve true
        }
      }
    }

    return false; // No hay bombas en las celdas circundantes
  }

  // Fa una jugada de la màquina, només busca la primera posició lliure
  void checkSurroundings(int row, int col) {
    // Define las direcciones alrededor de la celda (arriba, abajo, izquierda, derecha, diagonales, etc.)
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

    int bombCount = 0; // Inicializa el contador de bombas cercanas

    for (var direction in directions) {
      int newRow = row + direction[0];
      int newCol = col + direction[1];

      // Verifica si las nuevas coordenadas están dentro de los límites del tablero
      if (newRow >= 0 &&
          newRow < board.length &&
          newCol >= 0 &&
          newCol < board[newRow].length) {
        String cellValue = board[newRow][newCol];
        if (cellValue == 'B') {
          // Si encuentra una bomba, incrementa el contador
          bombCount++;
        }
      }
    }

    if (bombCount > 0) {
      // Si hay bombas cercanas, coloca el número de bombas en lugar de "O"
      board[row][col] = bombCount.toString();
    } else {
      // Si no hay bombas cercanas, rellena con "0" y sigue verificando recursivamente
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
            // Llama a la función de forma recursiva para seguir rellenando celdas vacías
            checkSurroundings(newRow, newCol);
          }
        }
      }
    }
  }

  // Comprova si el joc ja té un tres en ratlla
  // No comprova la situació d'empat
  void checkGameWinner() {
    for (int i = 0; i < dift; i++) {
      for (int j = 0; j < dift; j++) {
        if (board[i][j] == "O") {
          checkSurroundings(i, j);
        }
      }
    }
    // No hi ha guanyador, torna '-'
  }

  // Carrega les imatges per dibuixar-les al Canvas
  Future<void> loadImages(BuildContext context) async {
    // Si ja estàn carregades, no cal fer res
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
