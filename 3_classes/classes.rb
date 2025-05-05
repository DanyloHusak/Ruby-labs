require 'json'

class Contact
  attr_accessor :name, :phone

  def initialize(name, phone)
    @name = name
    @phone = phone
  end
end

class ContactBook
  def initialize
    @contacts = []
  end

  def add_contact
    print "Ім'я: "
    name = gets.chomp
    print "Телефон: "
    phone = gets.chomp
    @contacts << Contact.new(name, phone)
  end

  def view_contacts
    if @contacts.empty?
      puts "Контакти відсутні."
    else
      puts "\nСписок контактів:"
      @contacts.each_with_index do |contact, i|
        puts "#{i + 1}. #{contact.name} - #{contact.phone}"
      end
    end
  end

  def edit_contact
    print "Номер контакту для редагування: "
    index = gets.to_i - 1
    if @contacts[index]
      print "Нове ім'я: "
      @contacts[index].name = gets.chomp
      print "Новий телефон: "
      @contacts[index].phone = gets.chomp
      puts "Контакт оновлено."
    end
  end

  def delete_contact
    print "Номер контакту для видалення: "
    index = gets.to_i - 1
    if @contacts[index]
      @contacts.delete_at(index)
      puts "Контакт видалено."
    end
  end

  def save_contacts
    File.write("classes.json", JSON.pretty_generate(@contacts.map { |c| { name: c.name, phone: c.phone } }))
    puts "Контакти збережено у файл."
  end
end

contact_book = ContactBook.new

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
  when 1 then contact_book.view_contacts
  when 2 then contact_book.add_contact
  when 3 then contact_book.edit_contact
  when 4 then contact_book.delete_contact
  when 5 then contact_book.save_contacts
  when 6 then break
  else break
  end
end