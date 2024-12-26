require_relative "./google/artwork/crawler"

class ChallengeRunner
  def self.run(artist_name)
    file_path = "#{parameterize(artist_name)}-paintings.html"
    response = Google::Artwork::Crawler.execute(file_path)
    pp response
  rescue StandardError => e
    puts e.message
  end

  private

  def self.parameterize(str)
    str.downcase.gsub(" ", "-")
  end
end
