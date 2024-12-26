# frozen_string_literal: true

ARTIST_HTML_FILE_PATH = "picasso-paintings.html"

RSpec.describe Google::Artwork::Crawler do
  describe "#execute" do
    context "when file does not exist" do
      subject(:result) { described_class.new("non-existent-file.html").execute }

      it "should raise an error" do
        expect { result }.to raise_error(SerpapiChallenge::ArtistError)
      end
    end

    subject(:result) { described_class.new(ARTIST_HTML_FILE_PATH).execute }

    it "should return the correct shape" do
      expect(result[:artworks]).to be_an(Array)
    end
  end
end
