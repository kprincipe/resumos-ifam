package vendas;

import java.util.ArrayList;
import java.util.List;

import entidade.Compra;

import controlador.ProdutoController;
import interfaces.TelaBuscaProduto;
import interfaces.TelaListarProdutos;

public class Venda {
	
	List<Compra> compras = new ArrayList<Compra>();
	
	private ProdutoController produtoController;
	
	public Venda(ProdutoController produtoController) {
		this.produtoController = produtoController;
	}
	
	public void cadastrarCliente() {
		
	}
	
	public void consultarProduto() {
		TelaBuscaProduto tbp = new TelaBuscaProduto(produtoController);
		TelaListarProdutos tlp = new TelaListarProdutos();
		tlp.listarProdutos(tbp.buscarProduto());
	}
	
	public void comprarProduto() {
		
	}
}
