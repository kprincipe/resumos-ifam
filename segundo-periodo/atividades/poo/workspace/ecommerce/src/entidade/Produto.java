package entidade;

public class Produto {

	private int codigo;
	private String descricao;
	private String unidade;
	private float qteEstoque = 0;
	private float preco;
	
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	
	public String getDescricao() {
		return descricao;
	}
	
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
	public String getUnidade() {
		return unidade;
	}
	
	public void setUnidade(String unidade) {
		this.unidade = unidade;
	}
	
	public float getQteEstoque() {
		return qteEstoque;
	}
	
	public void adicionarEstoque(float quantidade) {
		this.qteEstoque += quantidade;
	}
	
	public void reduzirEstoque(float quantidade) {
		this.qteEstoque -= quantidade;
	}
	
	public float getPreco() {
		return preco;
	}
	
	public void setPreco(float preco) {
		this.preco = preco;
	}
	
	@Override
	public String toString() {
		return "Produto [codigo=" + codigo + ", descricao=" + descricao + ", unidade=" + unidade + ", qteEstoque="
				+ qteEstoque + ", preco=" + preco + "]";
	}	
}
