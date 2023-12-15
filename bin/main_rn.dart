import 'dart:convert';
import 'dart:io';

import 'package:arvore_avl/arvore_rubro_negra.dart';

List<int> readIntegerListFromFile(String filePath) {
  try {
    File file = File(filePath);

    String content = file.readAsStringSync();
    List<dynamic> jsonData = jsonDecode(content);

    List<int> integerList = jsonData.map((item) => item as int).toList();

    return integerList;
  } catch (e) {
    print('Erro ao ler o arquivo: $e');
    return [];
  }
}

void main(List<String> arguments) {
  final dados = readIntegerListFromFile('assets/dados100_mil.txt');
  print('início...');
  DateTime dataInicial = DateTime.now();

  print('Arvore Rubro Negra:');
  ;
  final ArvoreRubroNegra arvoreRN = ArvoreRubroNegra(NoArvoreRN(0));

  for (var num in dados) {
    arvoreRN.inserirNoBalanceado(arvoreRN.raiz, num);
  }
  print(
      'Tempo para criar Árvore RubroNegro balanceada: ${DateTime.now().difference(dataInicial).inSeconds}s');
  dataInicial = DateTime.now();
  arvoreRN.imprimirEmOrdem(arvoreRN.raiz);
  print(
      'Tempo para imprimir em ordem Árvore AVL balanceada: ${DateTime.now().difference(dataInicial).inSeconds}s');
  print('fim...');

  print('\n\n\n\n\n\n');

  print('início...');
  dataInicial = DateTime.now();
  dados.sort();
  print(dados);
  print(
      'Tempo para imprimir dados em ordem padrão Dart (Quicksort para listas grandes e Insertion Sort para listas Pequenas): ${DateTime.now().difference(dataInicial).inSeconds}s');
  print('fim...');
}
