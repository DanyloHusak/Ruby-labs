require 'json'

contacts = []

def add_contact(contacts)
  print "Ім'я: "
  name = gets.chomp
  print "Телефон: "
  phone = gets.chomp
  contacts << { name: name, phone: phone }
end

def view_contacts(contacts)
  puts "\nКонтакти:"
  contacts.each_with_index do |c, i|
    puts "#{i + 1}. #{c[:name]} - #{c[:phone]}"
  end
end

def edit_contact(contacts)
  print "Номер контакту для редагування: "
  index = gets.to_i - 1
  if contacts[index]
    print "Нове ім'я: "
    contacts[index][:name] = gets.chomp
    print "Новий телефон: "
    contacts[index][:phone] = gets.chomp
  end
end

def delete_contact(contacts)
  print "Номер контакту для видалення: "
  index = gets.to_i - 1
  if contacts[index]
    contacts.delete_at(index)
    puts "Видалено."
  end
end

def save_contacts(contacts)
  File.write("contacts.json", JSON.pretty_generate(contacts))
  puts "Контакти збережено у файл."
end

loop do
  puts "\n1. Переглянути контакти"
  puts "2. Додати контакт"
  puts "3. Редагувати контакт"
  puts "4. Видалити контакт"
  puts "5. Зберегти у файл"
  puts "6. Вийти"
  print "Ваш вибір: "
  choice = gets.to_i

  case choice
  when 1 then view_contacts(contacts)
  when 2 then add_contact(contacts)
  when 3 then edit_contact(contacts)
  when 4 then delete_contact(contacts)
  when 5 then save_contacts(contacts)
  when 6 then break
  else break
  end
end