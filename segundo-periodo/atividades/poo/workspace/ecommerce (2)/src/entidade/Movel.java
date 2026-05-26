package entidade;

public class Movel extends Produto {
	private float altura;
	private float profundidade;
	private float largura;
	private String cor;
	private String material;
	public float getAltura() {
		return altura;
	}
	public void setAltura(float altura) {
		this.altura = altura;
	}
	public float getProfundidade() {
		return profundidade;
	}
	public void setProfundidade(float profundidade) {
		this.profundidade = profundidade;
	}
	public float getLargura() {
		return largura;
	}
	public void setLargura(float largura) {
		this.largura = largura;
	}
	public String getCor() {
		return cor;
	}
	public void setCor(String cor) {
		this.cor = cor;
	}
	public String getMaterial() {
		return material;
	}
	public void setMaterial(String material) {
		this.material = material;
	}
	@Override
	public String toString() {
		super.toString();
		return "Imovel [altura=" + altura + ", profundidade=" + profundidade + ", largura=" + largura + ", cor=" + cor
				+ ", material=" + material + ", getAltura()=" + getAltura() + ", getProfundidade()=" + getProfundidade()
				+ ", getLargura()=" + getLargura() + ", getCor()=" + getCor() + ", getMaterial()=" + getMaterial()
				+ ", getCodigo()=" + getCodigo() + ", getDescricao()=" + getDescricao() + ", getUnidade()="
				+ getUnidade() + ", getQteEstoque()=" + getQteEstoque() + ", getPreco()=" + getPreco() + ", toString()="
				+ super.toString() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + "]";
	}
	
	
}
