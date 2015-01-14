require("sinatra")
require("sinatra/reloader")
also_reload("./lib/**/*.rb")
require("./lib/car_lot")

get("/") do
  @vehicles = Vehicle.all()
  erb(:index)
end

post("/vehicle") do
  make = params.fetch("make")
  model = params.fetch("model")
  year = params.fetch("year")
  vehicle = Vehicle.new(make, model, year)
  vehicle.save()
  @vehicles = Vehicle.all()
  erb(:index)
end

get("/vehicles/:id") do
  @vehicle = Vehicle.find(params.fetch("id"))
  erb(:vehicle)
end
