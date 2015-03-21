class MatchesController < ApplicationController

  swagger_controller :matches, "Matches"

  swagger_api :index do
    summary "Fetches all User items"
    notes "This lists all the active users"
    param :query, :page, :integer, :optional, "Page number"
    param :path, :nested_id, :integer, :optional, "Team Id"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
  end

  def index
    @matches = SlamAPI::Match.all
    render 'index.json.jbuilder'
  end

  def create
    match = SlamAPI::Match.new(parsed_params)
    on_success = Proc.new { render json: nil, status: 201 }
    on_fail = Proc.new { render json: nil, status: 400 }
    match.create(on_success, on_fail)
  end

  def destroy
    SlamAPI::Match.destroy_match(parsed_params[:id])
    render json: nil, status: 200
  end

  def parsed_params
    params.tap do |param|
      param.keys.map do |key|
        param[key.to_s.underscore] = param.delete(key)
      end
    end
  end
end
