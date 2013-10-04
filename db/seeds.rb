require 'csv'

CSV.foreach("db/Workouts.csv", :headers => true, :header_converters => :symbol) do |row|
  r = Wod.new(name: row[:name],
                    desc: row[:desc],
                    wod_type: row[:wod_type],
                    seq: row[:seq],
                    baserep: row[:baserep])
                    
  r.save
end

