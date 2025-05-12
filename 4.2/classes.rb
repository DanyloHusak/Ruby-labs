require 'json'

class Sport
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def to_hash
    { name: @name }
  end

  def self.from_hash(hash)
    new(hash[:name])
  end
end

class Team
  attr_accessor :name, :phones

  def initialize(name, phones)
    @name = name
    @phones = phones
  end

  def to_hash
    { name: @name, phones: @phones }
  end

  def self.from_hash(hash)
    new(hash[:name], hash[:phones])
  end
end

class Competition
  attr_accessor :id, :name, :sports, :teams

  def initialize(id, name, sports, teams)
    @id = id
    @name = name
    @sports = sports
    @teams = teams
  end

  def to_hash
    {
      id: @id,
      name: @name,
      sports: @sports.map(&:to_hash),
      teams: @teams.map(&:to_hash)
    }
  end

  def self.from_hash(hash)
    sports = hash[:sports].map { |s| Sport.from_hash(s) }
    teams = hash[:teams].map { |t| Team.from_hash(t) }
    new(hash[:id], hash[:name], sports, teams)
  end
end

class CompetitionManager
  def initialize
    @competitions = load_from_file
  end

  def list
    @competitions.each do |c|
      puts "ID: #{c.id}, Назва: #{c.name}"
      puts "  Види спорту: #{c.sports.map(&:name).join(', ')}"
      puts "  Команди:"
      c.teams.each do |t|
        puts "    #{t.name} (#{t.phones.join(', ')})"
      end
    end
  end

  def add
    print "ID: "
    id = gets.to_i
    print "Назва змагання: "
    name = gets.chomp

    print "Види спорту (через кому): "
    sports = gets.chomp.split(',').map(&:strip).map { |s| Sport.new(s) }

    teams = []
    print "Кількість команд: "
    team_count = gets.to_i
    team_count.times do
      print "Назва команди: "
      team_name = gets.chomp
      print "Телефони (через кому): "
      phones = gets.chomp.split(',').map(&:strip)
      teams << Team.new(team_name, phones)
    end

    @competitions << Competition.new(id, name, sports, teams)
  end

  def edit
    print "ID: "
    id = gets.to_i
    comp = @competitions.find { |c| c.id == id }
    return unless comp

    print "Нова назва: "
    comp.name = gets.chomp

    print "Нові види спорту (через кому): "
    comp.sports = gets.chomp.split(',').map(&:strip).map { |s| Sport.new(s) }

    teams = []
    print "Кількість команд: "
    team_count = gets.to_i
    team_count.times do
      print "Назва команди: "
      team_name = gets.chomp
      print "Телефони (через кому): "
      phones = gets.chomp.split(',').map(&:strip)
      teams << Team.new(team_name, phones)
    end
    comp.teams = teams
  end

  def delete
    print "ID: "
    id = gets.to_i
    @competitions.reject! { |c| c.id == id }
  end

  def search
    print "Ключове слово: "
    keyword = gets.chomp.downcase
    @competitions.each do |c|
      if c.name.downcase.include?(keyword)
        puts "ID: #{c.id}, Назва: #{c.name}"
      end
    end
  end

  def save
    data = @competitions.map(&:to_hash)
    File.write("contacts.json", JSON.pretty_generate(data))
  end

  private

  def load_from_file
    return [] unless File.exist?("contacts.json")
    data = JSON.parse(File.read("contacts.json"), symbolize_names: true)
    data.map { |item| Competition.from_hash(item) }
  end
end

manager = CompetitionManager.new

loop do
  puts "\n1. Перегляд\n2. Додавання\n3. Редагування\n4. Видалення\n5. Пошук\n6. Зберегти\n7. Вихід"
  print "Оберіть: "
  case gets.to_i
  when 1 then manager.list
  when 2 then manager.add
  when 3 then manager.edit
  when 4 then manager.delete
  when 5 then manager.search
  when 6 then manager.save
  when 7 then break
  end
end