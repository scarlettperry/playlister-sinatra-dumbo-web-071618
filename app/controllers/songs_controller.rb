class SongsController < ApplicationController
  get "/songs" do
    @songs = Song.all
    erb :"songs/index"
  end

  get "/songs/new" do
    erb :"songs/new"
  end

  #Song.new(name: "")

  post "/songs" do
    #binding.pry
    @song = Song.new(name: params["song_name"])
    # params[:song_artist_name].each do |artist|
    new_artist = Artist.create(name: params["song_artist_name"])
    @song.artist=new_artist
    # binding.pry
    #params[:song_genres][:name].each do |genre|
    new_genre = Genre.create(name: params["song_genre_name"])
    @song.genres << new_genre
    @song.save
    redirect to ("/songs/#{@song.slug}")
    #binding.pry
  end

  get "/songs/:slug" do
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/show"
  end
end
