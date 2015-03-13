require "slam_api/matches"

RSpec.describe SlamAPI::Matches do
  it 'retrieves all the matches' do
    attributes = {
      :player_one => "taka",
      :player_two => "eric"
    }

    match = SlamAPI::Matches.new(attributes)
    match.create

    expect(SlamAPI::Matches.all).to include(match)
  end

  it "assigns a uuid to a match" do
    attributes = {
      :player_one => "taka",
      :player_two => "eric"
    }
    match = SlamAPI::Matches.new(attributes)
    match.create
    
    expect(SlamAPI::Matches.all[0].id).to_not be_nil
  end

  it "not valid with only one player" do
    attributes = {
      :player_one => "taka"
    }
    match = SlamAPI::Matches.new(attributes)
    expect(match.valid?).to eq(false)
  end

  it "is valid when two players are present" do
    attributes = {
      :player_one => "taka",
      :player_two => "eric"
    }
    match = SlamAPI::Matches.new(attributes)
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
