require 'httparty'
# get '/test.html' do

# 	content_type :json
# 	salad = {
# 		name: "Basic Salad",
# 		ingredients: ['lettuce', 'tomatoes', 'chicken', 'cheese', 'croutons'],
# 	}

# 	salad.to_json
# end


# get '/' do

	url = "http://api.randomuser.me/"
	response = HTTParty.get(url)

	# content_type :json
	userCity = response['results'][0]['user']['location']['city'].gsub(" ", "+");

	puts userCity

	url2 = "https://maps.googleapis.com/maps/api/geocode/json?address=" + userCity + "=YOUR API KEY"

      # mapOptions = {
      #   center: { lat: latitude, lng: longitude},
      #   zoom: 13
      # }
      
      # map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

    response_google = HTTParty.get(url2);

    userlat = response_google['results'][0]['geometry']['location']['lat']
    userlng = response_google['results'][0]['geometry']['location']['lng']

    puts userlat
    puts userlng
# end








