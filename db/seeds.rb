# db/seeds.rb

environment_seed_file = File.join(Rails.root, 'db', 'seeds', "#{Rails.env}.rb")
if File.exist?(environment_seed_file)
  load(environment_seed_file)
else
  puts "No seed file found for environment: #{Rails.env}"
end
