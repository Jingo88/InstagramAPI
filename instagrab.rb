require 'pry'
require 'json'
require 'httparty'
require 'sinatra'

# In this scenario you have TWO erb files. 
counter = 1
api_key = File.new("api_key.txt", "r")
	while (line = api_key.gets)
		theapi = "#{line}"
		counter = counter+1
	end
api_key.close


puts "this is your API KEY!!!  #{theapi}"


get ("/") do
	erb(:city)
end

get ("/city") do

	location = request.params['city'].gsub(" ", "+")
	# location = location.gsub(" ", "+")

	url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}=#{theapi}"
	response_google = HTTParty.get(url)

  	userlat = response_google['results'][0]['geometry']['location']['lat']
	userlng = response_google['results'][0]['geometry']['location']['lng']

	response = HTTParty.get("https://api.instagram.com/v1/media/search?lat=#{userlat}&lng=#{userlng}&client_id=#{theapi}")

	picArr = []

	response["data"].each do |x|
		picArr<<"<li><img src='#{x["images"]["standard_resolution"]["url"]}'></li>"
	end

	pics = "<div><ul>" + picArr.join('') + "</ul></div>"

	erb(:city2, {locals: {tag: request.params["city"], pics: pics}})
	
end



# Write a Sinatra app that does the following:

# On index.erb, have a form to get a city and state from the user.
# At this point the browser should refresh with a new page showing pictures taken in and around that city.
# On your server, use HTTParty to hit instagram's api (you'll need your key!) and get pictures taken near said city.
# Instagram requires longitude and latitude, so we better hit google's api (you'll need your key!) to get those coordinates for the city.
# Have the pictures populate on results.erb.















