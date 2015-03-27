require 'rails_helper'

RSpec.describe MatchesController, type: :controller do
  render_views

  describe "index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "returns a json response of all the matches" do
      match = SlamAPI::Matches.new(
        :player_one => "taka",
        :player_two => "eric"
      )

      match.create

      get :index, format: :json

      json_response = JSON.parse(response.body)
      expect(json_response.first["playerOne"]).to eq("taka")
      expect(json_response.first["playerTwo"]).to eq("eric")
    end
  end

  describe "destroy" do
    it "destroys a match" do
      match = SlamAPI::Matches.new(
        :player_one => "taka",
        :player_two => "eric"
      )

      match.create

      delete :destroy, { :id => match.id }

      expect(response.code).to eq("200")

      matches = SlamAPI::Matches.all
      expect(matches).to be_empty
    end
  end

  describe "create" do
    it "returns a 201 created" do
      match_params = {
        :playerOne => "taka",
        :playerTwo => "lisa"
      }

      post :create, match_params, :format => "json"

      expect(response.code).to eq("201")
    end

    it "creates a new match" do 
      match_params = {
        :playerOne => "taka",
        :playerTwo => "lisa"
      }

      puts "SlamAPI::Matches.all.count: #{SlamAPI::Matches.all.count}"

      expect {
        post :create, match_params, :format => "json"
      }.to change{SlamAPI::Matches.all.count}.by(1)

      puts "SlamAPI::Matches.all.count: #{SlamAPI::Matches.all.count}"

      match = SlamAPI::Matches.all.last
      expect(match.player_one).to eq("taka")
    end
  end
end
