require "slam_api/match"

RSpec.describe SlamAPI::Match do

  let(:valid_attributes) {{ :player_one => "taka", :player_two => "eric" }}

  context ".all" do
    it "retrieves all the matches" do
      match = SlamAPI::Match.new(valid_attributes)
      match.create

      expect(SlamAPI::Match.all).to include(match)
    end
  end

  it "assigns a uuid to a match" do
    match = SlamAPI::Match.new(valid_attributes)
    match.create

    expect(SlamAPI::Match.all[0].id).to_not be_nil
  end

  context ".find_by_id" do
    it "finds the match by its id" do
      match = SlamAPI::Match.new(valid_attributes)
      match.create

      expect(SlamAPI::Match.find_by_id(match.id)).to eq(match)
    end
  end

  context "#create" do
    it "returns on_success when valid" do
      match = SlamAPI::Match.new(valid_attributes)
      on_success = proc { true }
      on_fail = proc { false }
      expect(match.create(on_success, on_fail)).to be true
    end

    it "returns on_fail when not valid" do
      attributes = {}
      match = SlamAPI::Match.new(attributes)
      on_success = proc { false }
      on_fail = proc { true }
      expect(match.create(on_success, on_fail)).to be true
    end
  end

  context "#destroy_match" do
    it "deletes a match" do
      match = SlamAPI::Match.new(valid_attributes)
      match.create
      SlamAPI::Match.destroy_match(match.id)
      
      expect(SlamAPI::Match.all).to be_empty
    end
  end

  context "#valid?" do
    it "not valid with only one player" do
      attributes = {
        :player_one => "taka"
      }
      match = SlamAPI::Match.new(attributes)
      expect(match.valid?).to eq(false)
    end

    it "is valid when two players are present" do
      match = SlamAPI::Match.new(valid_attributes)
      expect(match.valid?).to eq(true)
    end

    it "does not create a match with invalid parameters" do
      attributes = {
        :player_one => "taka"
      }
      match = SlamAPI::Match.new(attributes)
      match.create
      expect(SlamAPI::Match.all.empty?).to eq(true) 
    end  
  end
end
