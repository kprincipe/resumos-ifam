package entidade;

public class Compra {
	
	public static final int cadastrada = 1;
	public static final int concluida = 2;
	
	private int codigo;
	private Produto produto;
	private Cliente cliente;
	private float quantidade;
	private int status;
	
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	public Produto getProduto() {
		return produto;
	}
	public void setProduto(Produto produto) {
		this.produto = produto;
	}
	public Cliente getCliente() {
		return cliente;
	}
	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}
	public float getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(float quantidade) {
		this.quantidade = quantidade;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	
}
