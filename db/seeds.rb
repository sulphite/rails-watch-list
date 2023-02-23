# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "open-uri"
require "json"

puts "destroying movies"
Movie.destroy_all
puts "recreating movies"


url = "https://api.themoviedb.org/3/movie/top_rated?api_key=fbfa6a20ad4439d3be0d46f120ea3e92&language=en-US&page=1"
data = JSON.parse(URI.open(url).read)

# p data["results"].length


data["results"].each do |movie|
  Movie.create({
    title: movie["original_title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
    rating: movie["vote_average"].to_f
  })
end
