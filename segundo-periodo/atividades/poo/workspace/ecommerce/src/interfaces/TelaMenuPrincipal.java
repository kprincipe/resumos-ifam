package interfaces;

import util.Input;

public class TelaMenuPrincipal {

	public int menuPrincipal() {
		System.out.println("\nmenu principal");
		System.out.println();

		System.out.println("1. cadastrar produto.");
		System.out.println("2. buscar produto.");
		
		
		System.out.println("3. listar produtos.");
		System.out.println();

		System.out.println("4. cadastrar comprador.");
		System.out.println("5. listar compradores.");
		System.out.println("6. buscar comprador.");
		System.out.println();

		System.out.println("7. cadastrar cliente.");
		System.out.println("8. buscar cliente.");
		System.out.println();

		System.out.println("9. cadastrar fornecedor.");
		System.out.println("10. buscar fornecedor.");
    System.out.println("11. comprar Produto.");
		System.out.println();

		System.out.println("0. sair.");
    
		return Integer.parseInt(Input.get());
	}
}
