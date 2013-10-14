package dominio;

import java.util.HashMap;
import dominio.ValorInvalidoException;
import org.aspectj.lang.Signature;

public aspect ValidadorAspect {
	
	private HashMap<Persona, HashMap<String, Validador>> registro = new HashMap<Persona, HashMap<String, Validador>>();
	
	private String getNombreDeVariable(Signature signature){
		return signature.getName();
	}
	
	public void agregarValidador(Persona unaPersona, String variable, ValidarStringNoVacio unValidadorDeStringNoVacio){
		if(registro.containsKey(unaPersona))
			registro.get(unaPersona).put(variable, unValidadorDeStringNoVacio);
		else{
			registro.put(unaPersona, new HashMap<String, Validador>());
			registro.get(unaPersona).put(variable, unValidadorDeStringNoVacio);
		}
	}
	
	public boolean elValorEsValido(Object unValor, Validador validador) throws ValorInvalidoException{
		if(validador.validar(unValor))
			return true;
		else
			throw new ValorInvalidoException("El valor es invalido");
	}
	
	pointcut asignacionVariable(Persona p, String unNombre):
		set( * *..* ) && target(p) && args(unNombre);
	
	void around(Persona unaPersona, Object unValor): asignacionVariable(unaPersona, unValor){
		
		if(registro.containsKey(unaPersona)){
			if(registro.get(unaPersona).containsKey(getNombreDeVariable(thisJoinPoint.getSignature()))){
				if(elValorEsValido(unValor, registro.get(unaPersona).get(thisJoinPoint.getSignature().getName())))
					proceed(unaPersona, unValor);
			}
		}
	}
}
