require 'json'

competitions = []

def add_competition(competitions)
  print "ID: "
  id = gets.to_i
  print "Назва: "
  name = gets.chomp
  print "Види спорту (через кому): "
  sports = gets.chomp.split(',').map(&:strip)
  print "Команди (через кому): "
  teams = gets.chomp.split(',').map(&:strip)
  competitions << { id: id, name: name, sports: sports, teams: teams }
end

def edit_competition(competitions)
  print "ID: "
  id = gets.to_i
  comp = competitions.find { |c| c[:id] == id }
  return unless comp
  print "Нова назва: "
  comp[:name] = gets.chomp
  print "Нові види спорту (через кому): "
  comp[:sports] = gets.chomp.split(',').map(&:strip)
  print "Нові команди (через кому): "
  comp[:teams] = gets.chomp.split(',').map(&:strip)
end

def delete_competition(competitions)
  print "ID: "
  id = gets.to_i
  competitions.reject! { |c| c[:id] == id }
end

def search_competitions(competitions)
  print "Ключове слово: "
  keyword = gets.chomp.downcase
  competitions.each do |c|
    puts c if c[:name].downcase.include?(keyword)
  end
end

def save_to_file(competitions)
  File.write("contacts.json", JSON.pretty_generate(competitions))
end

def load_from_file
  return [] unless File.exist?("contacts.json")
  JSON.parse(File.read("contacts.json"), symbolize_names: true)
end

competitions = load_from_file

loop do
  puts "\n1. Перегляд\n2. Додавання\n3. Редагування\n4. Видалення\n5. Пошук\n6. Зберегти\n7. Вихід"
  print "Оберіть: "
  case gets.to_i
  when 1 then competitions.each { |c| puts c }
  when 2 then add_competition(competitions)
  when 3 then edit_competition(competitions)
  when 4 then delete_competition(competitions)
  when 5 then search_competitions(competitions)
  when 6 then save_to_file(competitions)
  when 7 then break
  end
end