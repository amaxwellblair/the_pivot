class StoresController < ApplicationController

  def index
    @stores = Store.all
  end
  #no stores yet. view will blow up

end
