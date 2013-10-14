package dominio;

public class ValidarStringNoVacio implements Validador<String> {

	@Override
	public boolean validar(String valor) {
		return valor.length() > 0;
	}
}
