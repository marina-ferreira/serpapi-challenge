# frozen_string_literal: true

require_relative "../challenge_runner"

desc "Search Google for artwork by artist name"

task :search_artwork do
  print "Enter Artist Name: "
  artist_name = STDIN.gets.chomp

  ChallengeRunner.run(artist_name)
end
