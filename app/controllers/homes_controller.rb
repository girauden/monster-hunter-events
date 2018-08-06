class HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:homepage]
  def homepage
  end
end
