package testing;

import static org.junit.Assert.*;
import org.junit.Test;
import dominio.*;

public class ContadorLlamadasTest {
	
	@Test
	
	public void sampleTest () {
		
		Persona p1 = new Persona () ;
		p1.getNombre();
		p1.setNombre("Nico");
		p1.setNombre("Carlos");
		
		Persona p2 = new Persona () ;
		
		int llamadas_p1_getNombre = ContadorLlamadas.aspectOf().cantLlamadas(p1,"getNombre");
		int llamadas_p1_setNombre = ContadorLlamadas.aspectOf().cantLlamadas(p1,"setNombre");
		int llamadas_p2_setNombre = ContadorLlamadas.aspectOf().cantLlamadas(p2,"setNombre");
		
		System.out.println(ContadorLlamadas.aspectOf().cantLlamadas(p1,"getNombre"));
		System.out.println(ContadorLlamadas.aspectOf().cantLlamadas(p1,"setNombre"));
		System.out.println(ContadorLlamadas.aspectOf().cantLlamadas(p2,"setNombre"));
		
		assertEquals (llamadas_p1_getNombre, 1);
		assertEquals (llamadas_p1_setNombre, 2) ;
		assertEquals (llamadas_p2_setNombre, 0) ;
	} 
}
