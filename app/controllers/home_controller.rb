class HomeController < ApplicationController
  def index
    @greeting = %w[Hi Hello Howdy Bonjour].sample
  end
end
