import 'package:arvore_avl/arvore_avl.dart';
import 'package:arvore_avl/no_arvore.dart';

enum CoresEnum {
  vermelho,
  preto,
}

class NoArvoreRN extends NoArvore {
  CoresEnum cor;
  NoArvoreRN? pai;

  @override
  final NoArvoreRN? esquerda;

  @override
  final NoArvoreRN? direita;

  NoArvoreRN(int valor, {this.pai, this.esquerda, this.direita})
      : cor = CoresEnum.vermelho,
        super(valor);
}

class ArvoreRubroNegra extends ArvoreBinariaAVL {
  @override
  final NoArvoreRN raiz;
  ArvoreRubroNegra(this.raiz) : super(raiz: raiz);

  NoArvoreRN inserirNoRN(NoArvoreRN noArvore, int valor) {
    // Encontrar o nó recém-inserido
    NoArvoreRN? novoNo = buscarNo(raiz, valor);

    super.inserirNo(noArvore, valor);

    // Corrigir propriedades da árvore rubro-negra
    corrigirInsercao(novoNo);
    return noArvore;
  }

  void corrigirInsercao(NoArvoreRN? no) {
    // Caso 1: O nó é a raiz
    if (no?.pai == null) {
      no?.cor = CoresEnum.preto;
    } else {
      // Caso 2: O pai é preto
      if (no?.pai!.cor == CoresEnum.preto) {
        return;
      } else {
        // Caso 3: Tio é vermelho
        NoArvoreRN? tio = obterTio(no);
        if (tio != null && tio.cor == CoresEnum.vermelho) {
          no?.pai!.cor = CoresEnum.preto;
          tio.cor = CoresEnum.preto;
          NoArvoreRN? avo = no?.pai!.pai;
          avo?.cor = CoresEnum.vermelho;
          corrigirInsercao(avo);
        } else {
          // Caso 4: Rotações
          NoArvoreRN? avo = no?.pai?.pai;
          if (no == no?.pai?.direita && no?.pai == avo?.esquerda) {
            rotacaoSimplesEsquerda(no?.pai);
            no = no?.esquerda;
          } else if (no == no?.pai?.esquerda && no?.pai == avo?.direita) {
            rotacaoSimplesDireita(no?.pai);
            no = no?.direita;
          }

          // Caso 5: Mais rotações
          avo = no?.pai?.pai;
          no?.pai?.cor = CoresEnum.preto;
          avo?.cor = CoresEnum.vermelho;
          if (no == no?.pai?.esquerda) {
            rotacaoSimplesDireita(avo);
          } else {
            rotacaoSimplesEsquerda(avo);
          }
        }
      }
    }
  }

  NoArvoreRN? obterTio(NoArvoreRN? no) {
    NoArvoreRN? avo = no?.pai?.pai;
    if (avo != null) {
      if (no == avo.esquerda) {
        return avo.direita;
      } else {
        return avo.esquerda;
      }
    }
    return null;
  }

  NoArvoreRN? buscarNo(NoArvoreRN? no, int valor) {
    if (no == null || no.valor == valor) {
      return no;
    }

    if (valor < no.valor) {
      return buscarNo(no.esquerda, valor);
    } else {
      return buscarNo(no.direita, valor);
    }
  }
}
