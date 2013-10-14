package dominio;

import java.util.HashMap;

public aspect ContadorLlamadas {
	
	private HashMap<Persona, HashMap<String, Integer>> contador = new HashMap<Persona, HashMap<String, Integer>>();
	
	private boolean contadorContieneUnaPersona(Persona unaPersona){
		return contador.containsKey(unaPersona);
	}
	
	private boolean contadorContieneUnMetodo(Persona unaPersona, String nombreDelMetodo){
		return contador.get(unaPersona).containsKey(nombreDelMetodo);
	}
	
	private void modificarContador(Persona unaPersona, String nombreDelMetodo, Integer valorViejo){
		contador.get(unaPersona).put(nombreDelMetodo, valorViejo+1);
	}
	
	public int cantLlamadas(Persona unaPersona, String nombreDelMetodo){
		
		int cantidad = 0;
		
		if(contador.containsKey(unaPersona)){
			if(contador.get(unaPersona).containsKey(nombreDelMetodo))
				cantidad = contador.get(unaPersona).get(nombreDelMetodo); 
		}
		
		return cantidad;
	}
	
	pointcut monitoredMethodsCall(Persona p):
		call(@Monitored * *..*(..)) && target(p);
	
	after(Persona unaPersona): monitoredMethodsCall(unaPersona){
		
		String nombreDelMetodo = thisJoinPointStaticPart.getSignature().getName();
			
		if(contadorContieneUnaPersona(unaPersona)){
			if(contadorContieneUnMetodo(unaPersona, nombreDelMetodo)){
				Integer valorViejo = contador.get(unaPersona).get(nombreDelMetodo);
				modificarContador(unaPersona, nombreDelMetodo, valorViejo);
			}
			else
				contador.get(unaPersona).put(nombreDelMetodo, 1);
		}
		else{
			contador.put(unaPersona, new HashMap<String, Integer>());
			contador.get(unaPersona).put(nombreDelMetodo, 1);
		}
	}
}
