import 'dart:convert';

import 'package:project_api/app/pages/data/http/exceptions.dart';
import 'package:project_api/app/pages/data/model/personagem_model.dart';

import '../http/http_client.dart';

abstract class IPersonagemRepository {
  Future<List<PersonagemModel>> getPersonagens();
}

class PersonagemRepository implements IPersonagemRepository {
  final IHttpClient client;

  PersonagemRepository({
    required this.client,
  });

  @override
  Future<List<PersonagemModel>> getPersonagens() async {
    final response =
        await client.get(url: "https://rickandmortyapi.com/api/character");

    if (response.statusCode == 200) {
      final List<PersonagemModel> personagens = [];

      final body = jsonDecode(response.body);

      body['results'].map((item) {
        final PersonagemModel personagem = PersonagemModel.fromMap(item);
        personagens.add(personagem);
      }).toList();

      return personagens;
    } else if (response.statusCode == 404) {
      throw NotFoundException("Erro ao carregar dados");
    } else {
      throw Exception("Erro");
    }
  }
}
