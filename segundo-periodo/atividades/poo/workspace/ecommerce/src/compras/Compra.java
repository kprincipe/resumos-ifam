package compras;

import java.util.ArrayList;
import java.util.List;

import controlador.ProdutoController;
import entidade.Pedido;
import interfaces.TelaCadastrarLivro;
import interfaces.TelaCadastrarMovel;
import interfaces.TelaSelecionarTipoProduto;

public class Compra {
	
	private List<Pedido> pedidos = new ArrayList<Pedido>();
	private ProdutoController produtoController;
	
	public Compra(ProdutoController produtoController){
		this.produtoController = produtoController;
	}
	
	public void cadastrarComprador() {
		
	}
	
	public void cadastrarProduto() {
		TelaSelecionarTipoProduto tstp = new TelaSelecionarTipoProduto();
		produtoController.cadastrarProduto(tstp.selecionarProduto());
	}
	
	public void cadastrarFornecedor() {
		
	}
	
	public void fazerPedido() {
		
	}
	
	public void receberPedido() {
		
	}
	
	public void cadastrarLivro() {
		TelaCadastrarLivro tcl = new TelaCadastrarLivro();
		produtoController.cadastrarProduto(tcl.cadastrarNovoLivro());
	}
	
	public void cadastrarMovel() {
		TelaCadastrarMovel tcm = new TelaCadastrarMovel();
		produtoController.cadastrarProduto(tcm.cadastrarNovoMovel());
	}
	
	public void listarPedidos() {
		
	}
}
