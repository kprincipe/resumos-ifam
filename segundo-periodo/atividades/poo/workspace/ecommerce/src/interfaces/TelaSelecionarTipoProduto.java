package interfaces;

import entidade.Produto;
import util.Input;

public class TelaSelecionarTipoProduto {
	public Produto selecionarProduto() {
		Produto produto = null;
		System.out.println("SELECIONAR PRODUTO");
		System.out.println("Escolha a opção 1 para livro");
		System.out.println("Escolha a opção 2 para movel");
		System.out.println("Escolha a opção 3 para outro produto");
		switch(Integer.parseInt(Input.get())) {
		case 1:
			TelaCadastrarLivro tcl = new TelaCadastrarLivro();
			produto = tcl.cadastrarNovoLivro();
			break;
		case 2:
			TelaCadastrarMovel tcm = new TelaCadastrarMovel();
			produto = tcm.cadastrarNovoMovel();
			break;
		case 3:
			TelaCadastrarProduto tcp = new TelaCadastrarProduto();
			produto = tcp.cadastrarNovoProduto();
			break;
			
		}
		return produto;
	}
}
