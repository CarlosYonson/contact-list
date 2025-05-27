require "json"

# Este struct representa un contacto en nuestra lista
# Cada contacto tiene nombre, fecha de cumpleaños, número de teléfono y correo electrónico
struct Contact
  # Esta línea permite convertir fácilmente entre JSON y objetos Contact
  include JSON::Serializable
  
  # Definimos los atributos básicos de un contacto
  getter name : String         # Nombre del contacto
  getter birthday : Time       # Fecha de cumpleaños
  getter number_phone : String # Número de teléfono
  getter email : String        # Correo electrónico

  # Constructor que inicializa un nuevo contacto
  def initialize(@name, @birthday, @number_phone, @email)
  end

  # Este método convierte el contacto a una cadena de texto formateada
  # para mostrar de forma bonita en la consola
  def to_s : String
    "Nombre: #{@name}\n" +
      "Cumpleaños: #{@birthday.to_s("%d/%m")}\n" +
      "Número de teléfono: #{@number_phone}\n" +
      "E-mail: #{@email}"
  end
end
