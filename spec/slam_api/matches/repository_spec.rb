require "slam_api/match"
require "slam_api/matches/repository"
require 'spec_helper'

RSpec.describe SlamAPI::Matches::Repository do

  let(:valid_attributes) {{ :player_one => "taka", :player_two => "eric" }}

  module SlamAPI
    module Config
      def self.create_storage_registry
        if ENV["ENV"] != "test"
          SlamAPI::Sql.new
        else
          SlamAPI::Memory.new
        end
      end
    end
  end

  before(:each) do
    db = SlamAPI::Config.create_storage_registry
    @repository = SlamAPI::Matches::Repository.new(db)
  end

  context ".all" do
    it "retrieves all the matches" do
      match = SlamAPI::Match.new(valid_attributes)
      @repository.create(match)

      expect(@repository.all).to include(match)
    end
  end

  it "assigns a uuid to a match" do
    match = SlamAPI::Match.new(valid_attributes)
    @repository.create(match)

    expect(@repository.all[0].id).to_not be_nil
  end

  context ".find_by_id" do
    it "finds the match by its id" do
      match = SlamAPI::Match.new(valid_attributes)
      @repository.create(match)

      expect(@repository.find_by_id(match.id)).to eq(match)
    end
  end

  context "#destroy_match" do
    it "deletes a match" do
      match = SlamAPI::Match.new(valid_attributes)
      @repository.create(match)
      @repository.destroy_match(match.id)

      expect(@repository.all).to be_empty
    end
  end

  context "#valid?" do
    it "does not create a match with invalid parameters" do
      attributes = {
        :player_one => "taka"
      }
      match = SlamAPI::Match.new(attributes)
      @repository.create(match)
      expect(@repository.all.empty?).to eq(true)
    end
  end
end
