class StaticPagesController < ApplicationController
  def home
  	@replay = params[:id] || ""
  end
end
