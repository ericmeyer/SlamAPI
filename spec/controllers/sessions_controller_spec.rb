require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "Logging in" do
    it "is hardcoded to return success" do
      post :create, format: "json"

      parsedBody = JSON.parse(response.body)
      expect(parsedBody.fetch("success")).to be true
      expect(parsedBody.fetch("token")).to eq("ABC123")
    end
  end

end
