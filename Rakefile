require './driver'

task :bot do |t|
   Driver.run
end

task :flush do |t|
  Jouer::Connection.db.flushall
end
