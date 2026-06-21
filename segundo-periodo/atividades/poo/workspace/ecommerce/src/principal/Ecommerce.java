package principal;

import compras.Compra;
import controlador.ClienteController;
import controlador.CompradorController;
import controlador.FornecedorController;
import controlador.ProdutoController;
import interfaces.TelaMenuPrincipal;
import vendas.VendaController;
import fornecedor.Fornecedor;

public class Ecommerce {

	public static void main (String[] args) {
		TelaMenuPrincipal tmp = new TelaMenuPrincipal();
		
		ProdutoController produtoController = new ProdutoController();
		FornecedorController fornecedorController = new FornecedorController();
		CompradorController compradorController = new CompradorController();
		ClienteController clienteController = new ClienteController();

		Fornecedor fornecedor = new Fornecedor(fornecedorController);
		Compra compra = new Compra(produtoController, compradorController);
		VendaController venda = new VendaController(produtoController, clienteController);

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
				produtoController.listarProdutos();
				break;
			case 4:
				compra.cadastrarComprador();
				break;
			case 5:
				compra.listarCompradores();
				break;
			case 6:
				compra.buscarComprador();
				break;
			case 7:
				venda.cadastrarCliente();
				break;
			case 8:
				venda.consultarCliente();
				break;
			case 9:
				fornecedor.cadastrarFornecedor();
				break;
			case 10:
				fornecedor.buscarFornecedor();
				break;
			case 11:
				venda.comprarProduto();
				break;
			case 0:
				return;
			default:
				System.out.println("Opcao invalida!");
			}
		} while (opcao > 0 && opcao < 12);
	}
}
