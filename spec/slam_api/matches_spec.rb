require "slam_api/matches"

RSpec.describe SlamAPI::Matches do

  let(:valid_attributes) {{ :player_one => "taka", :player_two => "eric"}}

  context ".all" do
    it "retrieves all with single match" do
      match = create_match(valid_attributes)

      expect(SlamAPI::Matches.all).to include(match)
      expect(SlamAPI::Matches.pending_matches).to eq(1)
    end


    it "retrieves all with two matches" do
      match = create_match(valid_attributes)
      match2 = create_match(valid_attributes)

      expect(SlamAPI::Matches.all).to include(match)
      expect(SlamAPI::Matches.pending_matches).to eq(2)
    end

    it "retrieves matches sorted by creation date" do
      match = create_match(valid_attributes)
      match2 = create_match(valid_attributes)

      expect(SlamAPI::Matches.all.first).to eq(match)
    end
  end

  it "assigns a uuid to a match" do
    match = create_match(valid_attributes)

    expect(SlamAPI::Matches.all[0].id).to_not be_nil
  end

  context ".find_by_id" do
    it "finds the match by its id" do
      match = create_match(valid_attributes)

      expect(SlamAPI::Matches.find_by_id(match.id)).to eq(match)
    end
  end

  context "#destroy_match" do
    it "deletes a match" do
      match = create_match(valid_attributes)

      SlamAPI::Matches.destroy_match(match.id)
      
      expect(SlamAPI::Matches.all).to be_empty
    end
  end

  context "#valid?" do
    it "not valid with only one player" do
      attributes = {
        :player_one => "taka"
      }
      match = create_match(attributes)
      expect(match.valid?).to eq(false)
    end

    it "is valid when two players are present" do
      match = create_match(valid_attributes)
      expect(match.valid?).to eq(true)
    end

    it "does not create a match with invalid parameters" do
      attributes = {
        :player_one => "taka"
      }
      match = create_match(attributes)
      expect(SlamAPI::Matches.all.empty?).to eq(true) 
    end  
  end

  def create_match(valid_attributes)
    match = SlamAPI::Matches.new(valid_attributes)
    match.create
    match
  end
end
