import 'package:arvore_avl/arvore_binaria.dart';
import 'package:arvore_avl/no_arvore.dart';

class ArvoreBinariaAVL extends ArvoreBinaria {
  ArvoreBinariaAVL({required super.raiz});

  /// [0] : A árvore está equilibrada.
  /// [1] : A subárvore esquerda é mais profunda que a subárvore direita.
  /// [-1] : A subárvore direita é mais profunda que a subárvore esquerda.
  int getBalanceFactor() {
    return alturaArvore(raiz.direita) - alturaArvore(raiz.esquerda);
  }

  void inserirNoBalanceado(NoArvore? noArvore, int valor) {
    // final firstBF = getBalanceFactor();
    // print('- - - - - - - - - - - - - - - - - - - - -');
    // print('Balance Factor antes da inserção de $valor: $firstBF');
    super.inserirNo(noArvore, valor);
    final secondBF = getBalanceFactor();

    // print('Balance Factor depois da inserção de $valor: $secondBF');

    if (secondBF == 0 || secondBF == 1 || secondBF == -1) {
      // print('Árvore balanceada!');
    } else {
      // print(
      //     'Árvore desbalanceada à ${secondBF == -2 ? 'esquerda' : 'direita'}!');
      // imprimirEmNivel();
      // print('Balanceando...');
      // Adicionado à esquerda
      if (secondBF <= -2) {
        // A inserção foi à direita da subárvore esquerda (LL).
        if (valor < raiz.esquerda!.valor) {
          raiz = rotacaoSimplesEsquerda(raiz);
        } else {
          // A inserção foi à esquerda da subárvore esquerda (LR).
          rotacaoDuplaEsquerda();
        }
      } else
      // Adicionado à direita
      if (secondBF >= 2) {
        if (raiz.direita!.valor < valor) {
          raiz = rotacaoSimplesDireita(raiz);
        } else {
          rotacaoDuplaDireita();
        }
      }
      // print(
      //     'Balance Factor depois do balanceamento de $valor: ${getBalanceFactor()}');
    }

    // print('Imprimindo em nível:');
    // imprimirEmNivel();

    // print('- - - - - - - - - - - - - - - - - - - - -\n');
  }

  /// Função para realizar a rotação LL em uma árvore AVL
  NoArvore rotacaoSimplesEsquerda(NoArvore? noArvore) {
    // Passo 1: Salvar referências aos nós envolvidos
    final no = noArvore?.esquerda;
    // Passo 2: Realizar a rotação
    noArvore?.esquerda = no?.direita;
    no?.direita = noArvore;

    // Passo 3: Retornar a nova raiz da subárvore

    return no!;
  }

  /// Função para realizar a rotação RR em uma árvore AVL
  NoArvore rotacaoSimplesDireita(NoArvore? noArvore) {
    // Passo 1: Salvar referências aos nós envolvidos
    final no = noArvore?.direita;
    // Passo 2: Realizar a rotação
    noArvore?.direita = no?.esquerda;
    no?.esquerda = noArvore;

    // Passo 3: Retornar a nova raiz da subárvore

    return no!;
  }

  /// LR
  void rotacaoDuplaEsquerda() {
    raiz.esquerda = rotacaoSimplesDireita(raiz.esquerda!);
    raiz = rotacaoSimplesEsquerda(raiz);
  }

  /// RL
  void rotacaoDuplaDireita() {
    raiz.direita = rotacaoSimplesEsquerda(raiz.direita!);
    raiz = rotacaoSimplesDireita(raiz);
  }
}
