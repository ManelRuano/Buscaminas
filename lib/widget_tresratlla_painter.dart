import 'dart:ui' as ui;
import 'package:flutter/material.dart'; // per a 'CustomPainter'
import 'app_data.dart';

// S'encarrega del dibuix personalitzat del joc
class WidgetTresRatllaPainter extends CustomPainter {
  int dicultat = 0;
  final AppData appData;

  WidgetTresRatllaPainter(this.appData);

  void dif() {
    switch (appData.dificultad) {
      case "facil":
        dicultat = 9;
        break;
      case "dificil":
        dicultat = 15;
        break;
    }
  }

  // Dibuixa les linies del taulell
  void drawBoardLines(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5.0;

    dif();
    // Definim els punts on es creuaran les línies verticals
    final double firstVertical = size.width / dicultat;
    final double secondVertical = 2 * size.width / dicultat;
    final double trindVertical = 3 * size.width / dicultat;
    final double fourVertical = 4 * size.width / dicultat;
    final double fiveVertical = 5 * size.width / dicultat;
    final double sixVertical = 6 * size.width / dicultat;
    final double sevenVertical = 7 * size.width / dicultat;
    final double eightVertical = 8 * size.width / dicultat;
    final double nineVertical = 9 * size.width / dicultat;
    final double tenVertical = 10 * size.height / dicultat;
    final double elevenVertical = 11 * size.height / dicultat;
    final double twelveVertical = 12 * size.height / dicultat;
    final double thirteenVertical = 13 * size.height / dicultat;
    final double fourteenVertical = 14 * size.height / dicultat;

    // Dibuixem les línies verticals

    // Definim els punts on es creuaran les línies horitzontals
    final double firstHorizontal = size.height / dicultat;
    final double secondHorizontal = 2 * size.height / dicultat;
    final double trindHorizontal = 3 * size.height / dicultat;
    final double fourHorizontal = 4 * size.height / dicultat;
    final double fiveHorizontal = 5 * size.height / dicultat;
    final double sixHorizontal = 6 * size.height / dicultat;
    final double sevenHorizontal = 7 * size.height / dicultat;
    final double eightHorizontal = 8 * size.height / dicultat;
    final double nineHorizontal = 9 * size.height / dicultat;
    final double tenHorizontal = 10 * size.height / dicultat;
    final double elevenHorizontal = 11 * size.height / dicultat;
    final double twelveHorizontal = 12 * size.height / dicultat;
    final double thirteenHorizontal = 13 * size.height / dicultat;
    final double fourteenHorizontal = 14 * size.height / dicultat;

    // Dibuixem les línies horitzontals
    List<double> listahorizontal = [];
    switch (appData.dificultad) {
      case "facil":
        dicultat = 9;
        listahorizontal = [
          firstHorizontal,
          secondHorizontal,
          trindHorizontal,
          fourHorizontal,
          fiveHorizontal,
          sixHorizontal,
          sevenHorizontal,
          eightHorizontal,
        ];
        break;
      case "dificil":
        dicultat = 15;
        listahorizontal = [
          firstHorizontal,
          secondHorizontal,
          trindHorizontal,
          fourHorizontal,
          fiveHorizontal,
          sixHorizontal,
          eightHorizontal,
          nineHorizontal,
          tenHorizontal,
          elevenHorizontal,
          twelveHorizontal,
          thirteenHorizontal,
          fourteenHorizontal
        ];
        break;
    }

    for (int i = 0; i < listahorizontal.length; i++) {
      double numero = listahorizontal[i];
      canvas.drawLine(Offset(0, numero), Offset(size.width, numero), paint);
      canvas.drawLine(Offset(numero, 0), Offset(numero, size.height), paint);
    }
  }

  // Dibuixa la imatge centrada a una casella del taulell
  void drawImage(Canvas canvas, ui.Image image, double x0, double y0, double x1,
      double y1) {
    double dstWidth = x1 - x0;
    double dstHeight = y1 - y0;

    double imageAspectRatio = image.width / image.height;
    double dstAspectRatio = dstWidth / dstHeight;

    double finalWidth;
    double finalHeight;

    if (imageAspectRatio > dstAspectRatio) {
      finalWidth = dstWidth;
      finalHeight = dstWidth / imageAspectRatio;
    } else {
      finalHeight = dstHeight;
      finalWidth = dstHeight * imageAspectRatio;
    }

    double offsetX = x0 + (dstWidth - finalWidth) / dicultat;
    double offsetY = y0 + (dstHeight - finalHeight) / dicultat;

    final srcRect =
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dstRect = Rect.fromLTWH(offsetX, offsetY, finalWidth, finalHeight);

    canvas.drawImageRect(image, srcRect, dstRect, Paint());
  }

  // Dibuixa el taulell de joc (creus i rodones)
  void drawBoardStatus(Canvas canvas, Size size) {
    switch (appData.dificultad) {
      case "facil":
        dicultat = 9;
        break;
      case "dificil":
        dicultat = 15;
        break;
    }
    // Dibujar números en lugar de 'X' o 'O' y mantener las bombas ocultas
    double cellWidth = size.width / dicultat;
    double cellHeight = size.height / dicultat;

    for (int i = 0; i < dicultat; i++) {
      for (int j = 0; j < dicultat; j++) {
        String cellValue = appData.board[i][j];
        if (cellValue != '-') {
          if (cellValue == 'F') {
            // Dibuja la letra "F" en el centro de la celda
            final textStyle = TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            );

            final textPainter = TextPainter(
              text: TextSpan(text: 'F', style: textStyle),
              textDirection: TextDirection.ltr,
            );

            textPainter.layout(
              maxWidth: cellWidth,
            );

            final position = Offset(
              j * cellWidth + (cellWidth - textPainter.width) / 2,
              i * cellHeight + (cellHeight - textPainter.height) / 2,
            );

            textPainter.paint(canvas, position);
          } else if (cellValue != 'B') {
            // Dibuja el número en el centro de la celda
            final textStyle = TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            );

            final textPainter = TextPainter(
              text: TextSpan(text: cellValue, style: textStyle),
              textDirection: TextDirection.ltr,
            );

            textPainter.layout(
              maxWidth: cellWidth,
            );

            final position = Offset(
              j * cellWidth + (cellWidth - textPainter.width) / 2,
              i * cellHeight + (cellHeight - textPainter.height) / 2,
            );

            textPainter.paint(canvas, position);
          }
        }
      }
    }
  }

  // Dibuixa el missatge de joc acabat
  void drawGameOver(Canvas canvas, Size size) {
    int dicultat = 0;
    bool perdud = false;
    String message = "";
    switch (appData.dificultad) {
      case "facil":
        dicultat = 9;
      case "dificil":
        dicultat = 15;
    }
    for (int i = 0; i < appData.board.length; i++) {
      for (int j = 0; j < appData.board[i].length; j++) {
        if (appData.board[i][j] == 'X') {
          perdud = true;
        }
      }
    }
    if (perdud = true) {
      message = "El joc ha acabat. has perdud";
    }
    if (perdud = false) {
      message = "El joc ha acabat. has guañat";
    }

    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    final textPainter = TextPainter(
      text: TextSpan(text: message, style: textStyle),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      maxWidth: size.width,
    );

    // Centrem el text en el canvas
    final position = Offset(
      (size.width - textPainter.width) / dicultat - 2,
      (size.height - textPainter.height) / dicultat - 2,
    );

    // Dibuixar un rectangle semi-transparent que ocupi tot l'espai del canvas
    final bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.7) // Ajusta l'opacitat com vulguis
      ..style = PaintingStyle.fill;

    canvas.drawRect(bgRect, paint);

    // Ara, dibuixar el text
    textPainter.paint(canvas, position);
  }

  // Funció principal de dibuix
  @override
  void paint(Canvas canvas, Size size) {
    drawBoardLines(canvas, size);
    drawBoardStatus(canvas, size);
    if (appData.gameIsOver == true) {
      drawGameOver(canvas, size);
    }
  }

  // Funció que diu si cal redibuixar el widget
  // Normalment hauria de comprovar si realment cal, ara només diu 'si'
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
