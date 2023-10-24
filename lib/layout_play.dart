import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget_tresratlla.dart';
import 'app_data.dart';

class LayoutPlay extends StatefulWidget {
  const LayoutPlay({Key? key}) : super(key: key);

  @override
  LayoutPlayState createState() => LayoutPlayState();
}

class LayoutPlayState extends State<LayoutPlay> {
  late int secondsElapsed;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    secondsElapsed = 0;
    // Iniciar un temporizador que incrementa los segundos cada segundo
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        secondsElapsed++;
      });
      if (gameOverConditionMet()) {
        timer
            ?.cancel(); // Detener el temporizador cuando se cumple la condición de game over
      }
    });
  }

  bool gameOverConditionMet() {
    // Agrega aquí la condición para verificar si el juego ha terminado.
    // Por ejemplo, puedes usar `Provider` para verificar si `AppData` tiene el juego finalizado.
    // Supongamos que tienes un booleano `gameIsOver` en `AppData` que indica el estado del juego.
    final appData = Provider.of<AppData>(context, listen: false);
    return appData.gameIsOver;
  }

  @override
  void dispose() {
    // Asegurarse de detener el temporizador cuando el widget se descarte
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Consumer<AppData>(
          builder: (context, appData, child) {
            return Text(
                "Tiempo: $secondsElapsed s  bombas :${appData.totalBombs} ");
          },
        ),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WidgetTresRatlla(),
            ],
          ),
        ),
      ),
    );
  }
}
