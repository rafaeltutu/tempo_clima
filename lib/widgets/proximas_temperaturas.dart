import 'package:flutter/material.dart';
import 'package:tempo_clima/models/previsao_hora.dart';

class ProximasTemperaturas extends StatelessWidget {
  final List<PrevisaoHora> previsoes;

  const ProximasTemperaturas({Key? key, required this.previsoes})
      : super(key: key);

  Card criarCardPrevisao(int i) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(9)),
          Image(image: AssetImage('images/${previsoes[i].numeroIcone}.png')),
          Padding(padding: EdgeInsets.all(2)),
          Padding(padding: EdgeInsets.all(5)),
          Text(previsoes[i].horario),
          Padding(padding: EdgeInsets.all(8)),
          Text('${previsoes[i].temperatura.toStringAsFixed(0)} ºC'),
          Padding(padding: EdgeInsets.all(8)),
          Text(previsoes[i].descricao),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: previsoes.length,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return criarCardPrevisao(i);
        },
      ),
    );
  }
}
