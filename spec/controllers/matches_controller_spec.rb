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
      match = SlamAPI::Match.new(
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
      match = SlamAPI::Match.new(
        :player_one => "taka",
        :player_two => "eric"
      )

      match.create

      delete :destroy, { :id => match.id }

      expect(response.code).to eq("200")

      matches = SlamAPI::Match.all
      expect(matches).to be_empty
    end
  end

  describe "create" do
    it "creates a match" do
      json = {:playerOne => "taka",
              :playerTwo => "lisa"}
      #request.env['CONTENT_TYPE'] = 'application/json'

      post :create, json

      expect(response.code).to eq("201")

      match = SlamAPI::Match.all.first

      expect(match.player_one).to eq("taka")
    end
  end
end
