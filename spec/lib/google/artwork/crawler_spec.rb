# frozen_string_literal: true

ARTIST_HTML_FILE_PATH = "van-gogh-paintings.html"

require "pry"

RSpec.describe Google::Artwork::Crawler do
  describe "#execute" do
    subject(:result) { described_class.new(ARTIST_HTML_FILE_PATH).execute }

    it "should return the correct shape" do
      expect(result[:artworks]).to be_an(Array)
    end

    context "when file does not exist" do
      subject(:result) { described_class.new("non-existent-file.html").execute }

      it "should raise an error" do
        expect { result }.to raise_error(SerpapiChallenge::ArtistError)
      end
    end

    context "when file is not readable" do
      before { allow_any_instance_of(described_class).to receive(:document).and_return(nil) }
      subject(:result) { described_class.new(ARTIST_HTML_FILE_PATH).execute }

      it "should raise an error" do
        expect { result }.to raise_error(SerpapiChallenge::HTMLError)
      end
    end

    context "when artworks are not found" do
      before { allow_any_instance_of(described_class).to receive(:artworks).and_return(nil) }
      subject(:result) { described_class.new(ARTIST_HTML_FILE_PATH).execute }

      it "should raise an error" do
        expect { result }.to raise_error(SerpapiChallenge::HTMLError)
      end
    end
  end
end
