package principal;

import compras.Compra;
import controlador.ProdutoController;
import interfaces.TelaMenuPrincipal;
import vendas.Venda;

public class Ecommerce {
	
	
	public static void main(String[] args) {
		TelaMenuPrincipal tmp = new TelaMenuPrincipal();
		ProdutoController produtoController = new ProdutoController();
		Compra compra = new Compra(produtoController);
		Venda venda = new Venda(produtoController);
		
		int opcao = 0;
		
		do {
			opcao = tmp.menuPrincipal();
			
			switch (opcao) {
			case 1:
				compra.cadastrarProduto();
				break;
			case 2:
				venda.consultarProduto();
				break;
			case 3:
				return;
			}
		} while (opcao < 3);
	}

}
