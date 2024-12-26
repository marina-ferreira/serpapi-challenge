# frozen_string_literal: true

ARTIST_HTML_FILE_PATH = "van-gogh-paintings.html"

RSpec.describe Google::Artwork::ImageReplacerScriptParser do
  let(:document) do
    crawler = Google::Artwork::Crawler.new(ARTIST_HTML_FILE_PATH)
    crawler.send(:document)
  end

  describe "#parse" do
    subject(:result) { described_class.parse(document) }

    context "with valid image replacer script" do
      it "returns a hash" do
        expect(result).to be_a(Hash)
      end

      it "contains image IDs as keys and base64 strings as values" do
        expect(result.keys).to all(be_a(String))
        expect(result.values).to all(be_a(String))
      end
    end

    context "when no image replacer script is present" do
      before do
        allow_any_instance_of(described_class).to receive(:image_replacer_script).and_return("")
      end

      it "returns an empty hash" do
        expect(result).to eq({})
      end
    end

    context "when processing base64 strings with hex padding" do
      let(:mock_script) do
        <<~SCRIPT
          _setImagesSrc(function(){s ="base64string\\x3d\\x3d";var ii = ["image_id"]})
        SCRIPT
      end

      before do
        allow_any_instance_of(described_class).to receive(:image_replacer_script).and_return(mock_script)
      end

      it "correctly replaces hex padding with '='" do
        expect(result["image_id"]).to end_with("==")
      end
    end
  end
end
