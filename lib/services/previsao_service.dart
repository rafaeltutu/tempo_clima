import 'package:flutter/material.dart';
import 'package:tempo_clima/models/previsao_hora.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';

class PrevisaoService {
  final String baseUrlApi = 'dataservice.accuweather.com';
  final String path = '/forecasts/v1/hourly/12hour/44944';
  final Map<String, String> params = {
    'apikey': 'l8HnyHi5lxuH6x0TaiV1v9Os0rM2KnA4',
    'language': 'pt-BR',
    'metric': 'true'
  };

  Future<List<PrevisaoHora>> recuperarUltimasPrevisoes() async {
    final resposta = await get(Uri.https(baseUrlApi, path, params));

    if (resposta.statusCode == 200) {
      Iterable it = json.decode(resposta.body);
      List<PrevisaoHora> previsoes =
          List.from(it.map((obj) => PrevisaoHora.trasformarJSON(obj)));
      return previsoes;
    } else {
      throw Exception('Falha ao Carregar as previsoes');
    }
  }
}
