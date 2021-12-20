import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tempo_clima/controller/tema_controller.dart';

class Resumo extends StatelessWidget {
  final String? cidade;
  final String? descricao;
  final double? temperatraAtual;
  final double? temperaturaMaxima;
  final double? temperaturaMinima;
  final int? numeroIcone;

  const Resumo(
      {Key? key,
      this.cidade,
      this.descricao,
      this.temperatraAtual,
      this.temperaturaMaxima,
      this.temperaturaMinima,
      this.numeroIcone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Icon(Icons.brightness_6_outlined),
                Switch(
                  value: TemaController.instancia.usarTemaEscuro,
                  onChanged: (valor) {
                    TemaController.instancia.trocarTema();
                  },
                )
              ],
            ),
          ],
        ),
        Text(
          cidade!,
          style: TextStyle(fontSize: 18),
        ),
        Padding(padding: EdgeInsets.all(8)),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('images/$numeroIcone.png'),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Text(
                '${temperatraAtual!.toStringAsFixed(0)} ºC',
                style: TextStyle(fontSize: 40),
              ),
              VerticalDivider(
                color: Colors.black,
                thickness: 1.5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${temperaturaMaxima!.toStringAsFixed(0)} ºC',
                  ),
                  Text(
                    '${temperaturaMinima!.toStringAsFixed(0)} ºC',
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(5)),
        Text(
          descricao!,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
