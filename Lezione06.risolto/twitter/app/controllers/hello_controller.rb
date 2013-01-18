class HelloController < ApplicationController
  def index
    @personaggi = ["pluto", "paperino", "topolino", "minni"]
    render "index"
  end
  
  def about
    render :text => "SOno about"    
  end
end
