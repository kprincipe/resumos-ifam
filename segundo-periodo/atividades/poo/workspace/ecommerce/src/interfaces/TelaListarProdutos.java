package interfaces;

import java.util.List;

import entidade.Produto;

public class TelaListarProdutos {
	public void listarProdutos(List<Produto> produtos) {
		int i = 0;
		for (Produto produto : produtos) {
			System.out.print(i++);
			System.out.print(", ");
			System.out.println(produto);
		}
	}
}
