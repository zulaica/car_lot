require("sinatra")
require("sinatra/reloader")
also_reload("./lib/**/*.rb")
require("./lib/car_lot")
require("./lib/dealership")

get("/") do
  @dealerships = Dealership.all()
  erb(:index)
end

post("/dealership") do
  name = params.fetch("name")
  Dealership.new(name).save()
  @dealerships = Dealership.all
  erb(:index)
end

post("/vehicle") do
  make = params.fetch("make")
  model = params.fetch("model")
  year = params.fetch("year")
  @vehicle = Vehicle.new(make, model, year)
  @vehicle.save()
  @dealership = Dealership.find(params.fetch("dealership_id").to_i())
  @dealership.add_vehicle(@vehicle)
  erb(:dealership)
end

get("/vehicles/:id") do
  @vehicle = Vehicle.find(params.fetch("id"))
  erb(:vehicle)
end

get("/dealership/:id") do
  @dealership = Dealership.find(params.fetch("id").to_i())
  erb(:dealership)
end
