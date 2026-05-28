package controlador;

import java.util.ArrayList;
import java.util.List;

import entidade.Livro;
import entidade.Movel;
import entidade.Produto;

public class ProdutoController {
	private List<Produto> produtos = new ArrayList<Produto>();
	
	public void cadastrarProduto(Produto produto) {
		produtos.add(produto);
	}
	
	public void atualizarProduto(Produto produto) {
		
	}
	
	public List<Produto> buscarProdutos(String chave) {
		if (chave == "" || chave.isEmpty() || chave == null) return produtos;
		
		List <Produto> produtosBusca = new ArrayList<Produto>();
		
		String chaveMin = chave.toLowerCase();
		
		for(Produto produto : produtos) {
			if(produto instanceof Livro) {
				Livro livro = (Livro) produto;
				if(livro.getTitulo().contains(chaveMin) ||
					livro.getAutor().contains(chaveMin))
					produtosBusca.add(produto);
			} else if (produto instanceof Movel) {
				Movel movel = (Movel) produto;
				if(movel.getCor().contains(chaveMin) ||
					movel.getMaterial().contains(chaveMin))
					produtosBusca.add(produto);
			} else {
				if(produto.getDescricao().contains(chave))
					produtosBusca.add(produto);
			}
		}
		return produtosBusca;
	}
}
