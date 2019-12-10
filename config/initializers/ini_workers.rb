$LOAD_PATH << File.join(__dir__, '..', '..', 'app', 'workers')

Dir[File.expand_path('../../app/workers/*.rb', File.dirname(__FILE__))].each do |file|
  require(file)
end
