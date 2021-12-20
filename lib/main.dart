import 'package:flutter/material.dart';
import 'package:tempo_clima/controller/tema_controller.dart';
import 'package:tempo_clima/widgets/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    LigarTema(),
  );
}

class LigarTema extends StatelessWidget {
  const LigarTema({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: TemaController.instancia,
        builder: (context, child) {
          return MaterialApp(
            title: 'Tempo Clima',
            theme: TemaController.instancia.usarTemaEscuro
                ? ThemeData.dark()
                : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            home: Home(),
          );
        });
  }
}
