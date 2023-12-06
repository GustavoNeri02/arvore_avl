import 'package:arvore_avl/arvore_avl.dart';
import 'package:arvore_avl/no_arvore.dart';

void main(List<String> arguments) {
  final ArvoreBinariaAVL arvoreAVL = ArvoreBinariaAVL(raiz: NoArvore(50));
  arvoreAVL.inserirNoBalanceado(arvoreAVL.raiz, 25);
  arvoreAVL.inserirNoBalanceado(arvoreAVL.raiz, 26);
  arvoreAVL.inserirNoBalanceado(arvoreAVL.raiz, 52);
  arvoreAVL.inserirNoBalanceado(arvoreAVL.raiz, 51);
  print('ArvoreAVL Balance Factor: ${arvoreAVL.getBalanceFactor()}');
}
