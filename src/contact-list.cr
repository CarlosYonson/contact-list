require "./contact.cr"

class ContactList
  getter contacts : Array(Contact)

  def initialize
    @contacts = [] of Contact # Inicializa el array de contactos
  end

  # Agregar contacto
  def add_contact(contact : Contact)
    @contacts << contact
  end

  # Consultar contacto por nombre
  def find_contact(name : String) : Array(Contact)
    @contacts.select(&.name.downcase.includes?(name.downcase))
  end

  # Listar contactos en un mes seleccionado
  def list_by_birthday(month : Int32) : Array(Contact)
    @contacts.select { |contact| contact.birthday.month == month }
  end

  # Listar todos los contactos ordenados alfabéticamente por nombre
  def list_alphabetically : Array(Contact)
    @contacts.sort_by(&.name)
  end
end

contact1 = Contact.new("Luis Fernando Curi Quintal", Time.utc(2001, 7, 5), "9995671240", "cquintal@correo.uady.mx")
contact2 = Contact.new("Cristian de Martino Ricci", Time.utc(1995, 8, 11), "9971088545", "a23216380@alumnos.uady.mx")
contact3 = Contact.new("César Hernán Mendiburu Silveira", Time.utc(1988, 12, 3), "5559876543", "mendiburu.silveira@correo.uady.mx")
contact4 = Contact.new("Víctor Manuel Bautista Ancona", Time.utc(1992, 7, 21), "5552468135", "vbautista@correo.uady.mx")
contact5 = Contact.new("Giuseph Alexis Chan Torres", Time.utc(2000, 7, 10), "9992474244", "A15003490@alumnos.uady.mx")
contact6 = Contact.new("Brian Eumir Manzanilla Martin", Time.utc(2000, 8, 15), "9994911475", "A20203983@alumnos.uady.mx")
contact7 = Contact.new("Jorge Amir Salomón Carrión", Time.utc(2005, 12, 27), "9971333832", "A20203983@alumnos.uady.mx")
contact8 = Contact.new("Cristiano Ronaldo", Time.utc(2005, 12, 27), "9971333832", "cristiano.ronaldo@alumnos.uady.mx")

contact_list = ContactList.new

contact_list.add_contact(contact1)
contact_list.add_contact(contact2)
contact_list.add_contact(contact3)
contact_list.add_contact(contact4)
contact_list.add_contact(contact5)
contact_list.add_contact(contact6)
contact_list.add_contact(contact7)
contact_list.add_contact(contact8)

# contact_list.list_by_birthday(8).each do |contact|
#   puts contact.to_s
# end

# contact_list.list_alphabetically.each do |contact|
#   puts contact.to_s
# end

contacts = contact_list.find_contact("cristian")

puts "Contactos encontrados:"
contacts.each_with_index do |contact, index|
  puts "#{index + 1}. #{contact.name}"
end
