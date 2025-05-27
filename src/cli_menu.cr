require "./contact-list.cr"

# Esta función muestra el menú principal de la aplicación
# y gestiona la navegación entre las diferentes opciones
def main_menu
  # Creamos una nueva instancia de nuestra lista de contactos
  contact_list = ContactList.new
  
  # Este bucle mantiene el menú activo hasta que el usuario decida salir
  loop do
    puts "\n====== GESTOR DE CONTACTOS ======"
    puts "1. Agregar contacto"
    puts "2. Buscar contacto por nombre"
    puts "3. Listar contactos por mes de cumpleaños"
    puts "4. Listar todos los contactos (orden alfabético)"
    puts "0. Salir"
    print "Seleccione una opción: "
    
    # Leemos la opción seleccionada por el usuario
    option = gets.not_nil!.strip
    
    # Dirigimos al usuario a la función correspondiente según su elección
    case option
    when "1"
      add_contact(contact_list)
    when "2"
      search_contact(contact_list)
    when "3"
      list_by_month(contact_list)
    when "4"
      list_all(contact_list)
    when "0"
      # Antes de salir, guardamos todos los contactos
      contact_list.save_contacts
      puts "¡Hasta pronto!"
      break
    else
      puts "Opción no válida. Intente nuevamente."
    end
  end
end

# Esta función permite al usuario agregar un nuevo contacto
def add_contact(contact_list : ContactList)
  puts "\n==== AGREGAR NUEVO CONTACTO ===="
  
  # Pedimos los datos del contacto
  print "Nombre: "
  name = gets.not_nil!.strip
  
  # Para la fecha de cumpleaños, verificamos que tenga el formato correcto
  birthday_time = nil
  loop do
    print "Fecha de cumpleaños (DD/MM): "
    birthday_str = gets.not_nil!.strip
    
    begin
      if birthday_str =~ /^(\d{1,2})\/(\d{1,2})$/
        day = $1.to_i
        month = $2.to_i
        
        # Usamos el año actual solo como referencia para crear el objeto Time
        current_year = Time.local.year
        birthday_time = Time.local(year: current_year, month: month, day: day)
        break
      else
        puts "Formato inválido. Use DD/MM."
      end
    rescue ex
      puts "Fecha inválida: #{ex.message}"
    end
  end
  
  # Continuamos pidiendo el resto de datos
  print "Número de teléfono: "
  phone = gets.not_nil!.strip
  
  print "Email: "
  email = gets.not_nil!.strip
  
  # Creamos el nuevo contacto y lo agregamos a la lista
  new_contact = Contact.new(name, birthday_time.not_nil!, phone, email)
  contact_list.add_contact(new_contact)
  contact_list.save_contacts
  
  puts "\n¡Contacto agregado correctamente!"
end

# Esta función permite buscar contactos por nombre
def search_contact(contact_list : ContactList)
  puts "\n==== BUSCAR CONTACTO ===="
  
  print "Ingrese el nombre a buscar: "
  name = gets.not_nil!.strip
  
  # Buscamos contactos que contengan el texto ingresado
  results = contact_list.find_contact(name)
  
  # Mostramos los resultados o un mensaje si no hay coincidencias
  if results.empty?
    puts "No se encontraron contactos con ese nombre."
  else
    puts "\nResultados encontrados (#{results.size}):"
    results.each_with_index do |contact, index|
      puts "\nContacto ##{index + 1}"
      puts contact.to_s
    end
  end
end

# Esta función permite listar contactos por mes de cumpleaños
def list_by_month(contact_list : ContactList)
  puts "\n==== LISTAR CONTACTOS POR MES DE CUMPLEAÑOS ===="
  
  # Mostramos la lista de meses para que el usuario elija
  month_names = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", 
                "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
  
  month_names.each_with_index do |month, index|
    puts "#{index + 1}. #{month}"
  end
  
  # El usuario selecciona un mes
  print "\nSeleccione el mes (1-12): "
  month = gets.not_nil!.strip.to_i
  
  # Verificamos que el mes sea válido
  if month < 1 || month > 12
    puts "Mes inválido."
    return
  end
  
  # Buscamos contactos que cumplan años en el mes seleccionado
  contacts = contact_list.list_by_birthday(month)
  
  # Mostramos los resultados
  if contacts.empty?
    puts "No hay contactos con cumpleaños en #{month_names[month - 1]}."
  else
    puts "\nContactos con cumpleaños en #{month_names[month - 1]}:"
    contacts.each_with_index do |contact, index|
      puts "\nContacto ##{index + 1}"
      puts contact.to_s
    end
  end
end

# Esta función muestra todos los contactos ordenados alfabéticamente
def list_all(contact_list : ContactList)
  puts "\n==== LISTA DE CONTACTOS (ORDEN ALFABÉTICO) ===="
  
  # Obtenemos todos los contactos ordenados por nombre
  contacts = contact_list.list_alphabetically
  
  # Mostramos la lista o un mensaje si no hay contactos
  if contacts.empty?
    puts "No hay contactos registrados."
  else
    puts "Total: #{contacts.size} contactos"
    contacts.each_with_index do |contact, index|
      puts "\nContacto ##{index + 1}"
      puts contact.to_s
    end
  end
end