import 'dart:html';
import 'package:flutter/material.dart';
import 'package:tempo_clima/models/previsao_hora.dart';
import 'package:tempo_clima/services/previsao_service.dart';
import 'package:tempo_clima/widgets/proximas_temperaturas.dart';
import 'resumo.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<PrevisaoHora>> ultimasPrevisoes;
  @override
  void initState() {
    super.initState();
    carregarPrevisoes();
  }

  void carregarPrevisoes() {
    PrevisaoService service = PrevisaoService();
    ultimasPrevisoes = service.recuperarUltimasPrevisoes();
  }

  Future<Null> atualizarPrevisoes() async {
    setState(() => carregarPrevisoes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text('Clima Tempo'),
        centerTitle: true,
        backgroundColor: Colors.black38,
      ),
      body: RefreshIndicator(
        onRefresh: atualizarPrevisoes,
        child: Center(
          child: FutureBuilder<List<PrevisaoHora>>(
            future: ultimasPrevisoes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<PrevisaoHora>? previsoes = snapshot.data;
                double temperaturaAtual = previsoes![0].temperatura;
                double menorTempertura = double.maxFinite;
                double maiorTemperatura = double.negativeInfinity;
                previsoes.forEach((objt) {
                  if (objt.temperatura < menorTempertura) {
                    menorTempertura = objt.temperatura;
                  }
                  if (objt.temperatura > maiorTemperatura) {
                    maiorTemperatura = objt.temperatura;
                  }
                });
                String describe = previsoes[0].descricao;
                int numeroIcone = previsoes[0].numeroIcone;

                return Column(
                  children: [
                    Resumo(
                      cidade: 'Curitiba',
                      temperatraAtual: temperaturaAtual,
                      temperaturaMaxima: maiorTemperatura,
                      temperaturaMinima: menorTempertura,
                      descricao: describe,
                      numeroIcone: numeroIcone,
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    ProximasTemperaturas(
                      previsoes: previsoes.sublist(1, previsoes.length),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Erro ao Carregar');
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
