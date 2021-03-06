class SongController < ApplicationController

	before do
    	payload_body = request.body.read

    	if(payload_body != "")
      		@payload = JSON.parse(payload_body).symbolize_keys
    	end
	end

	# get route
	get '/' do
		songs = Song.all
		{
			success: true,
			message: "Here are all #{songs.length} songs.",
			songs: songs
		}.to_json
	end

	# show route
	get '/:id' do
		shown_song = Song.find params[:id]
		{
			success: true,
			message: "Here is more information about #{shown_song.song_name}",
			shown_song: shown_song
		}.to_json
	end

	# create route
	post '/' do
		new_song = Song.new
		new_song.song_name = @payload[:song_name]
		new_song.artist_name = @payload[:artist_name]
		new_song.notes = @payload[:notes]
		new_song.link_to_file = @payload[:link_to_file]
		new_song.link_to_performance = @payload[:link_to_performance]
		new_song.user_id = @payload[:user_id]

		new_song.save
		{
			success: true,
			message: "You have successfully added #{new_song.song_name}.",
			new_song: new_song
		}.to_json

	end

	# edit route
	put '/:id' do
		updated_song = Song.find params[:id]
		updated_song.song_name = @payload[:song_name]
		updated_song.artist_name = @payload[:artist_name]
		updated_song.notes = @payload[:notes]
		updated_song.link_to_file = @payload[:link_to_file]
		updated_song.link_to_performance = @payload[:link_to_performance]
		updated_song.user_id = @payload[:user_id]

		updated_song.save
		{
			success: true,
			message: "You have successfully edited #{updated_song.song_name}.",
			updated_song: updated_song
		}.to_json
	end

	# delete route
	delete '/:id' do
		deleted_song = Song.find params[:id]
		deleted_song.destroy
		{
			success: true,
			message: "You have successfully deleted #{deleted_song.song_name}.",
			deleted_song: deleted_song
		}.to_json
	end
end
