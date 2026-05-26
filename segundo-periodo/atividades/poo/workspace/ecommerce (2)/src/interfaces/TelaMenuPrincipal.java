package interfaces;

import util.Input;

public class TelaMenuPrincipal {
	public int menuPrincipal() {
		System.out.println("menu principal");
		System.out.println("1. cadastrar produto.");
		System.out.println("2. buscar produto.");
		System.out.println("3. sair.");
		
		return Integer.parseInt(Input.get());
	}
}
