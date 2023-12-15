import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:arvore_avl/arvore_avl.dart';
import 'package:arvore_avl/arvore_rubro_negra.dart';
import 'package:arvore_avl/no_arvore.dart';

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
  executar_arvore_rubro_negra(dados);
  executar_arvore_avl(dados);
}

void executar_arvore_rubro_negra(List<int> dados) {
  print('início...');
  DateTime dataInicial = DateTime.now();

  print('Arvore Rubro Negra:');
  final ArvoreRubroNegra arvoreRN = ArvoreRubroNegra(NoArvoreRN(0));

  for (var num in dados) {
    arvoreRN.inserirNoBalanceado(arvoreRN.raiz, num);
  }
  print(
      'Tempo para criar Árvore RubroNegro balanceada: ${DateTime.now().difference(dataInicial).inSeconds}s');
  dataInicial = DateTime.now();
  arvoreRN.imprimirEmOrdem(arvoreRN.raiz);
  print(
      'Tempo para imprimir em ordem Árvore RubroNegro balanceada: ${DateTime.now().difference(dataInicial).inSeconds}s');
  print('fim...');

  print('\n\n\n\n\n\n');

  Random random = Random();
  for (int i = 0; i < 50000; i++) {
    int numeroSorteado = random.nextInt(19999) - 9999;

    if (numeroSorteado % 3 == 0) {
      arvoreRN.inserirNo(arvoreRN.raiz, numeroSorteado);
    } else if (numeroSorteado % 5 == 0) {
      arvoreRN.removerNo(arvoreRN.raiz, numeroSorteado);
    } else {
      int contagem = arvoreRN.contarOcorrencias(numeroSorteado);
      print("Número $numeroSorteado aparece na árvore $contagem vezes.");
    }
  }
}

void executar_arvore_avl(List<int> dados) {
  print('início...');
  DateTime dataInicial = DateTime.now();

  print('Arvore AVL:');

  final ArvoreBinariaAVL arvoreBinariaAVL = ArvoreBinariaAVL(raiz: NoArvore(0));

  for (var num in dados) {
    arvoreBinariaAVL.inserirNoBalanceado(arvoreBinariaAVL.raiz, num);
  }
  print(
      'Tempo para criar Árvore AVL balanceada: ${DateTime.now().difference(dataInicial).inSeconds}s');
  dataInicial = DateTime.now();
  arvoreBinariaAVL.imprimirEmOrdem(arvoreBinariaAVL.raiz);
  print(
      'Tempo para imprimir em ordem Árvore AVL balanceada: ${DateTime.now().difference(dataInicial).inSeconds}s');
  print('fim...');

  print('\n\n\n\n\n\n');

  Random random = Random();
  for (int i = 0; i < 50000; i++) {
    int numeroSorteado = random.nextInt(19999) - 9999;

    if (numeroSorteado % 3 == 0) {
      arvoreBinariaAVL.inserirNo(arvoreBinariaAVL.raiz, numeroSorteado);
    } else if (numeroSorteado % 5 == 0) {
      arvoreBinariaAVL.removerNo(arvoreBinariaAVL.raiz, numeroSorteado);
    } else {
      int contagem = arvoreBinariaAVL.contarOcorrencias(numeroSorteado);
      print("Número $numeroSorteado aparece na árvore $contagem vezes.");
    }
  }
}
