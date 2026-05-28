package interfaces;

import java.util.List;

import controlador.ProdutoController;
import entidade.Produto;
import util.Input;

public class TelaBuscaProduto {
	private ProdutoController produtoController;
	
	public TelaBuscaProduto(ProdutoController produtoController) {
		this.produtoController = produtoController;
	}
	
	public List<Produto> buscarProduto() {
		return produtoController.buscarProdutos(Input.get());
	}
}
