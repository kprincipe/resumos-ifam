package interfaces;

import entidade.Produto;
import util.Input;

public class TelaCadastrarProduto {
	
	public Produto cadastrarNovoProduto() {
		Produto produto = new Produto();
		System.out.println("CADASTRO DE PRODUTO");
		System.out.print("Informe a Descrição do Produto: ");
		produto.setDescricao(Input.get());
		System.out.print("Informe o Preço do Produto: ");
		produto.setPreco(Float.parseFloat(Input.get()));
		System.out.print("Informe a unidade: ");
		produto.setUnidade(Input.get());
		return produto;
	}
}
