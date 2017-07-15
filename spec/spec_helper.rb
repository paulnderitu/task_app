ENV['RACK_ENV'] = 'test'

require("rspec")
  require("pg")
  require("sinatra/activerecord")
  require("task")
  require("list")



  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM tasks *;")
      DB.exec("DELETE FROM lists *;")
    end
  end
