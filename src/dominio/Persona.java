package dominio;

public class Persona {
	private String nombre;
	private String apellido;
	
	@Monitored
	public String getNombre(){
		return nombre ;
	}
	
	@Monitored
	public void setNombre(String unNombre){
		nombre = unNombre ;
	}
	
	public void setApellido(String unApellido){
		apellido = unApellido;
	}
}
