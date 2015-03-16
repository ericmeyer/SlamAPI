require "slam_api/matches"

RSpec.describe SlamAPI::Matches do

  let(:valid_attributes) {{ :player_one => "taka", :player_two => "eric" }}

  context ".all" do
    it "retrieves all the matches" do
      match = SlamAPI::Matches.new(valid_attributes)
      match.create

      expect(SlamAPI::Matches.all).to include(match)
    end
  end

  it "assigns a uuid to a match" do
    match = SlamAPI::Matches.new(valid_attributes)
    match.create

    expect(SlamAPI::Matches.all[0].id).to_not be_nil
  end

  context ".find_by_id" do
    it "finds the match by its id" do
      match = SlamAPI::Matches.new(valid_attributes)
      match.create

      expect(SlamAPI::Matches.find_by_id(match.id)).to eq(match)
    end
  end

  context "#delete_match" do
    it "deletes a match" do
      match = SlamAPI::Matches.new(valid_attributes)
      match.create
      SlamAPI::Matches.delete_match(match.id)
      
      expect(SlamAPI::Matches.all).to be_empty
    end
  end

  context "#valid?" do
    it "not valid with only one player" do
      attributes = {
        :player_one => "taka"
      }
      match = SlamAPI::Matches.new(attributes)
      expect(match.valid?).to eq(false)
    end

    it "is valid when two players are present" do
      match = SlamAPI::Matches.new(valid_attributes)
      expect(match.valid?).to eq(true)
    end

    it "does not create a match with invalid parameters" do
      attributes = {
        :player_one => "taka"
      }
      match = SlamAPI::Matches.new(attributes)
      match.create
      expect(SlamAPI::Matches.all.empty?).to eq(true) 
    end  
  end
end
