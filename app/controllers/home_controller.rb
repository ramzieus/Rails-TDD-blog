class HomeController < ApplicationController
  def index
    @pages = Page.published
  end
end
