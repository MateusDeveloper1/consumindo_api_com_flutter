// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:project_api/app/pages/data/http/exceptions.dart';

import 'package:project_api/app/pages/data/model/personagem_model.dart';
import 'package:project_api/app/pages/data/repositories/personagem_repository.dart';

class PersonagemStore {
  final IPersonagemRepository repository;

  PersonagemStore({
    required this.repository,
  });
  //variavel reativa para loading
  final ValueNotifier<bool> isloading = ValueNotifier<bool>(false);

  //variavel reativa para o state
  final ValueNotifier<List<PersonagemModel>> state =
      ValueNotifier<List<PersonagemModel>>([]);

  //variavel reativa para erro
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  Future<void> getPersonagem() async {
    isloading.value = true;

    try {
      final result = await repository.getPersonagens();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isloading.value = false;
  }
}
