require "./contact.cr"

# Nombre del archivo donde se guardarán los contactos
CONTACTS_FILE = "contacts.json"

# Esta clase maneja toda la lógica para gestionar nuestros contactos
class ContactList
  # Lista de todos nuestros contactos
  getter contacts : Array(Contact)

  # Cuando creamos una nueva lista de contactos, cargamos los datos desde el archivo
  def initialize
    @contacts = load_contacts
  end

  # Este método carga los contactos desde el archivo JSON
  # Es privado porque solo se usa dentro de esta clase
  private def load_contacts
    if File.exists?(CONTACTS_FILE) && File.read(CONTACTS_FILE).strip.size > 0
      json_data = File.read(CONTACTS_FILE)
      # Deserializa el JSON a un Array de objetos Contact
      Array(Contact).from_json(json_data)
    else
      [] of Contact # Retorna un array vacío si el archivo no existe o está vacío
    end
  rescue ex
    puts "Error al cargar contactos: #{ex.message}"
    puts "Se iniciará con una lista de contactos vacía."
    [] of Contact
  end

  # Guarda todos los contactos en el archivo JSON
  def save_contacts
    json_data = @contacts.to_json
    File.write(CONTACTS_FILE, json_data)
  rescue ex
    puts "Error al guardar contactos: #{ex.message}"
  end

  # Agrega un nuevo contacto a la lista
  def add_contact(contact : Contact)
    @contacts << contact
  end

  # Busca contactos que contengan el nombre proporcionado (sin importar mayúsculas/minúsculas)
  def find_contact(name : String) : Array(Contact)
    @contacts.select(&.name.downcase.includes?(name.downcase))
  end

  # Encuentra todos los contactos que cumplen años en un mes específico
  def list_by_birthday(month : Int32) : Array(Contact)
    @contacts.select { |contact| contact.birthday.month == month }
  end

  # Devuelve todos los contactos ordenados alfabéticamente por su nombre
  def list_alphabetically : Array(Contact)
    @contacts.sort_by(&.name)
  end
end

# Estos son ejemplos de contactos que podrían añadirse
# Están comentados para que no se creen automáticamente
# contact1 = Contact.new("Luis Fernando Curi Quintal", Time.utc(2001, 7, 5), "9995671240", "cquintal@correo.uady.mx")
# contact2 = Contact.new("Cristian de Martino Ricci", Time.utc(1995, 8, 11), "9971088545", "a23216380@alumnos.uady.mx")
# contact3 = Contact.new("César Hernán Mendiburu Silveira", Time.utc(1988, 12, 3), "5559876543", "mendiburu.silveira@correo.uady.mx")
# contact4 = Contact.new("Víctor Manuel Bautista Ancona", Time.utc(1992, 7, 21), "5552468135", "vbautista@correo.uady.mx")
# contact5 = Contact.new("Giuseph Alexis Chan Torres", Time.utc(2000, 7, 10), "9992474244", "A15003490@alumnos.uady.mx")
# contact6 = Contact.new("Brian Eumir Manzanilla Martin", Time.utc(2000, 8, 15), "9994911475", "A20203983@alumnos.uady.mx")
# contact7 = Contact.new("Jorge Amir Salomón Carrión", Time.utc(2005, 12, 27), "9971333832", "A20203983@alumnos.uady.mx")
# contact8 = Contact.new("Cristiano Ronaldo", Time.utc(2005, 12, 27), "9971333832", "cristiano.ronaldo@alumnos.uady.mx")
