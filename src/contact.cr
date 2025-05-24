require "json"

struct Contact
  include JSON::Serializable
  getter name : String
  getter birthday : Time
  getter number_phone : String
  getter email : String

  def initialize(@name, @birthday, @number_phone, @email)
  end

  def to_s : String
    "Nombre: #{@name}\n" +
      "Cumpleaños: #{@birthday.to_s("%d/%m")}\n" +
      "Número de teléfono: #{@number_phone}\n" +
      "E-mail: #{@email}"
  end
end
