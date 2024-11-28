class Elemento{
  method esBueno()
}

class Hogar inherits Elemento{
  var property mugre
  var property confort

  override method esBueno(){
    return mugre <= confort *0.5
  }  

  method efectosDelAtaque(unaPlaga){
    mugre += unaPlaga.nivelDeDanio()
  }
}

class Huerta inherits Elemento{
  var cantProduccion 
  var nivelDeProduccion = produccion.nivel()
  override method esBueno(){
    return cantProduccion > nivelDeProduccion
  }

  method efectosDelAtaque(unaPlaga){
    cantProduccion -= (unaPlaga.nivelDeDanio() * 0.1 + 
    if (unaPlaga.transmitenEnfermedad()) {10} else {0}) //aca se podria poner una 0.max() para calcular que la prudccion llegue a menos de cero
  }
}

object produccion {
  var property nivel = 1000 // le pongo 1000 para ponerle un valor cualquiera, en el enunciado no lo especifica
}

class Mascota inherits Elemento{
  var property salud
  override method esBueno(){
    return salud > 250
  }

  method efectosDelAtaque(unaPlaga){
    if (unaPlaga.transmitenEnfermedad()) salud = 0.max(salud - unaPlaga.nivelDeDanio())
  }
}

class Barrio{
  const property elementos = []

  method cantElementosBuenos(){
    return elementos.count({e => e.esBueno()})
  }

  method cantElementosNoBuenos(){
    return elementos.count({e => not e.esBueno()})
  }

  method esCopado(){
    return self.cantElementosBuenos() > self.cantElementosNoBuenos()
  }
}

class Plaga{
  var poblacion
  method poblacion() = poblacion
  method nivelDeDanio()

  method transmitenEnfermedad(){
    return poblacion >= 10
  } 
  method efectosDelAtaque(){
    poblacion += poblacion * 0.1
  }

  method atacarAunElemento(unElemento){
    unElemento.efectosDelAtaque(self)
    self.efectosDelAtaque()
  }
}

class Cucaracha inherits Plaga{
  var property peso
  override method nivelDeDanio(){
    return poblacion * 0.5
  }
  override method transmitenEnfermedad(){
    return peso >= 10 and super()
  } 

  override method efectosDelAtaque(){
    peso += 2
    super()
  }
}

class Mosquito inherits Plaga{
  override method nivelDeDanio(){
    return self.poblacion()
  }

  override method transmitenEnfermedad(){
    return poblacion % 3 == 0 and super()
  } 
}

class Pulga inherits Plaga{
  override method nivelDeDanio(){
    return poblacion * 2
  }
}

class Garrapata inherits Pulga{
  override method efectosDelAtaque(){
    poblacion += poblacion * 0.2
  }
}