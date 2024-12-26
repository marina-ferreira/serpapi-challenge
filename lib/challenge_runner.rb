# frozen_string_literal: true

require_relative "./google/artwork/crawler"

# Entry point for the SerpApi artwork crawler challenge
class ChallengeRunner
  def self.run(artist_name)
    file_path = "#{Helpers::String.parameterize(artist_name)}-paintings.html"
    response = Google::Artwork::Crawler.execute(file_path)
    pp response
  rescue StandardError => e
    puts e.message
  end
end
