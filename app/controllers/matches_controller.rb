require 'slam_api/match'
require 'slam_api/matches/repository'
require 'slam_api/memory'

class MatchesController < ApplicationController
  def index
    @matches = repository.all
    render 'index.json.jbuilder'
  end

  def create
    match = SlamAPI::Match.new(parsed_params)
    repository.create(match)
    render json: nil, status: 201
  end

  def destroy
    repository.destroy_match(parsed_params[:id])
    render json: nil, status: 200
  end

  def parsed_params
    params.tap do |param|
      param.keys.map do |key|
        param[key.to_s.underscore] = param.delete(key)
      end
    end
  end

  private

  def db
    @db ||= SlamAPI::Memory.new
  end

  def repository
    @match_repository ||= SlamAPI::Matches::Repository.new(db)
  end
end
