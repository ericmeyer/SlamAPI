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

  context "#completed?" do
    it "a new game should not be completed" do
      match = SlamAPI::Matches.new(valid_attributes)
      match.create

      expect(SlamAPI::Matches.find_by_id(match.id).completed?).to eq(false)
    end
  end

  context "#complete_game" do
    it "moves a game to completed" do
      match = SlamAPI::Matches.new(valid_attributes)
      match.create

      match.complete_game

      expect(SlamAPI::Matches.find_by_id(match.id).completed?).to eq(true)
    end
  end

  context ".pending_matches" do
    it "doesnt have any matches" do
      match = SlamAPI::Matches.new(valid_attributes)
      match.create

      match.complete_game

      expect(SlamAPI::Matches.pending_matches).to be_empty
    end

    it "returns all incomplete matches" do
      match = SlamAPI::Matches.new(valid_attributes)
      match.create
      expect(SlamAPI::Matches.pending_matches).to eq([match])
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
