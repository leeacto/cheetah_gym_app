require 'CSV'

desc "Imports WODS into AR Table"
task :loadwod, [:filename] => :environment do
	CSV.foreach('lib/assets/Workouts.csv', headers: true) do |line|
		a = Wod.new(line.to_hash)
		a.baserep = 1 if a.baserep.isblank
		a.save!
	end
end