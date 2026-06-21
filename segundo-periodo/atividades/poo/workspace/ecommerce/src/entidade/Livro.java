package entidade;

public class Livro extends Produto {
	private String titulo;
	private String autor;
	private String edicao;
	private String editora;
	private int anoPublicacao;
	private String cidadePublicacao;
	private String isbn;
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public String getAutor() {
		return autor;
	}
	public void setAutor(String autor) {
		this.autor = autor;
	}
	public String getEdicao() {
		return edicao;
	}
	public void setEdicao(String edicao) {
		this.edicao = edicao;
	}
	public String getEditora() {
		return editora;
	}
	public void setEditora(String editora) {
		this.editora = editora;
	}
	public int getAnoPublicacao() {
		return anoPublicacao;
	}
	public void setAnoPublicacao(int anoPublicacao) {
		this.anoPublicacao = anoPublicacao;
	}
	public String getCidadePublicacao() {
		return cidadePublicacao;
	}
	public void setCidadePublicacao(String cidadePublicacao) {
		this.cidadePublicacao = cidadePublicacao;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	@Override
	public String toString() {
		super.toString();
		return "Livro [titulo=" + titulo + ", autor=" + autor + ", edicao=" + edicao + ", estoque=" + super.getQteEstoque() + "]";
	}
	
	
}
