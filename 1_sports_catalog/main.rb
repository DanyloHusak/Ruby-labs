require 'json'
require 'yaml'

competitions = []

def add_competition(competitions, id, name, sports, teams)
  competition = {
    id: id,
    name: name,
    sports: sports,
    teams: teams
  }
  competitions << competition
end

def edit_competition(competitions, id, new_name: nil, new_sports: nil, new_teams: nil)
  comp = competitions.find { |c| c[:id] == id }
  return unless comp
  comp[:name] = new_name if new_name
  comp[:sports] = new_sports if new_sports
  comp[:teams] = new_teams if new_teams
end

def delete_competition(competitions, id)
  competitions.reject! { |c| c[:id] == id }
end

def search_competitions(competitions, keyword)
  competitions.select { |c| c[:name].downcase.include?(keyword.downcase) }
end

def save_to_files(competitions)
  File.write("data.json", JSON.pretty_generate(competitions))
  File.write("data.yaml", YAML.dump(competitions))
end

def load_from_json
  return [] unless File.exist?("data.json")
  JSON.parse(File.read("data.json"), symbolize_names: true)
end

def load_from_yaml
  return [] unless File.exist?("data.yaml")
  YAML.load_file("data.yaml")
end

add_competition(competitions, 1, "Олімпіада", ["Біг", "Плавання"], ["Україна", "США"])
add_competition(competitions, 2, "Чемпіонат світу", ["Футбол"], ["Аргентина", "Франція"])

edit_competition(competitions, 1, new_name: "Олімпіада 2024", new_sports: ["Біг", "Гімнастика"])

delete_competition(competitions, 2)

puts "Пошук за словом 'олімпіада':"
results = search_competitions(competitions, "олімпіада")
puts results

save_to_files(competitions)

puts "Завантажено з JSON:"
puts load_from_json

puts "Завантажено з YAML:"
puts load_from_yaml