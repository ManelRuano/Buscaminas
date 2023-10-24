import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_data.dart';
import 'widget_tresratlla_painter.dart';

class WidgetTresRatlla extends StatefulWidget {
  const WidgetTresRatlla({Key? key}) : super(key: key);

  @override
  WidgetTresRatllaState createState() => WidgetTresRatllaState();
}

class WidgetTresRatllaState extends State<WidgetTresRatlla> {
  Future<void>? _loadImagesFuture;
  TapDownDetails? firstTapDetails; // Detalles del primer toque

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppData appData = Provider.of<AppData>(context, listen: false);
      _loadImagesFuture = appData.loadImages(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);
    int dicultat = 0;
    switch (appData.dificultad) {
      case "facil":
        dicultat = 9;
        break;
      case "dificil":
        dicultat = 15;
        break;
    }

    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        final int row =
            (details.localPosition.dy / (context.size!.height / dicultat))
                .floor();
        final int col =
            (details.localPosition.dx / (context.size!.width / dicultat))
                .floor();

        appData.playMove(row, col);
        setState(() {}); // Actualizar la vista
      },
      onDoubleTapDown: (details) {
        firstTapDetails = details; // Almacena los detalles del primer toque
      },
      onDoubleTap: () {
        if (firstTapDetails != null) {
          // Asegurarse de que haya ocurrido un toque inicial
          final int row = (firstTapDetails!.localPosition.dy /
                  (context.size!.height / dicultat))
              .floor();
          final int col = (firstTapDetails!.localPosition.dx /
                  (context.size!.width / dicultat))
              .floor();

          appData.flag(row, col);
          setState(() {});
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 56.0,
        child: FutureBuilder(
          future: _loadImagesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            } else {
              return CustomPaint(
                painter: WidgetTresRatllaPainter(appData),
              );
            }
          },
        ),
      ),
    );
  }
}
