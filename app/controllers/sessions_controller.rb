class SessionsController < ApplicationController

  def create
    render json: {
      success: true,
      token: "ABC123"
    }
  end
end
