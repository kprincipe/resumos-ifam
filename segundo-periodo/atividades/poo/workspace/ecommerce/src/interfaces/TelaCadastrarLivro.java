package interfaces;

import entidade.Livro;
import util.Input;

public class TelaCadastrarLivro {
	
	public Livro cadastrarNovoLivro() {
		Livro livro = new Livro();
		System.out.println("CADASTRO DE LIVRO");
		
		System.out.print("Informe o Título do Livro: ");
		livro.setTitulo(Input.get());
		
		System.out.print("Informe o Autor: ");
		livro.setAutor(Input.get());
		
		System.out.print("Informe o Preço: ");
		livro.setPreco(Float.parseFloat(Input.get()));
		
		System.out.print("Informe a Edição: ");
		livro.setEdicao(Input.get());
		
		System.out.print("Informe estoque do Livro: ");
		livro.adicionarEstoque(Integer.parseInt(Input.get()));
		
		System.out.print("Informe a Unidade: ");
		livro.setUnidade(Input.get());
		return livro;
	}
}
