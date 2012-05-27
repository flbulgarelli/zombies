require "rspec"
require "../../../src/main/ruby/zombies"

class GritableMock
  def initialize
    @gritado = false
  end
  def escucharGrito
    @gritado = true
  end
end

describe "zombies" do
  before(:each) do
    @zombie1 = Persona.new(150)
    @persona_sana = Persona.new(60)
    @persona_debil = Persona.new(4)
    @zombie1.volver_zombie
  end

  describe "direccion" do
    it "tiene metodos izquierda y derecha" do
      1.izquierda.should == - 1.derecha
    end
  end

  describe "personaje" do
    it "es escuchado por sus perseguidores cuando grita" do
      perseguidor1 = GritableMock.new
      perseguidor2 = GritableMock.new
      @persona_sana.instance_eval do
        perseguir_por(perseguidor1)
        perseguir_por(perseguidor2)
      end
      @persona_sana.gritar

      perseguidor1.gritado.should == true
      perseguidor2.gritado.should == true
    end
  end

  describe "zombie" do
    it "vuelve zombie a su victima cuando la muerde" do
      @zombie1.morder(@persona_sana)
      assertPuedeMorder(@persona_sana, @persona_debil)
    end

    it "se mueve a la mitad de velocidad de una persona" do
      @zombie1.caminar_derecha
      @zombie1.posicion_x.should == 5
    end

    it "pierde energia si se le grita" do
      @zombie1.escuchar_grito
      @zombie1.energia.should == 100
    end



  end

  describe "personaje" do
    it "se puede mover en ambas direcciones" do
      #Marcar esto
      @persona_sana.instance_eval do
        caminar_derecha
        caminar_derecha
        caminar_izquierda
      end
      @persona_sana.posicion_x.should == 10
    end
  end

   def assert_puede_morder(mordedor, mordido)
      lambda { mordedor.morder(mordido) }.should raise_error
   end
end

=begin
@Test(expected = RuntimeException)
void lasPersonasNoPuedenMorder() {
  personaSana.morder(personaDebil)
}

@Test(expected = RuntimeException)
void lasPersonasNoPuedeCorrerSiNoTienenEnergiaSuficiente() {
  personaDebil.correrDerecha()
}

@Test(expected = RuntimeException)
void lasPersonasNoPuedeGritarSiNoTienenEnergiaSuficiente() {
  personaDebil.gritar()
}

@Test(expected = RuntimeException)
void lasPersonasNoPuedenTrotarSiNoTienenEnergiaSuficiente() {
  personaDebil.trotarDerecha()
}

@Test(expected = RuntimeException)
void lasPersonasNoPuedenCaminarSiNoTienenEnergiaSuficiente() {
  personaDebil.caminarDerecha()
}

@Test(expected=RuntimeException)
void lasPersonasSonSordas() {
  personaSana.escucharGrito()
}
=end






