package interfaces;

import java.util.List;

import entidade.Produto;

public class TelaListarProdutos {
	public void listarProdutos(List<Produto> produtos) {
		for (Produto produto : produtos) {
			System.out.println(produto.toString());
		}
	}
}
