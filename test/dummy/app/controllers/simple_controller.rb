require "apotomo/stateful/simple_session_engine"

class SimpleController < ApplicationController
  include Apotomo::Stateful::SimpleSessionEngine
  
  def index
    render :nothing => true
  end
  
  has_widgets do |root|
    root << widget(:mouse_widget, 'mum')
  end
  
  def dashboard
    render :inline => "<%= render_widget 'mum' %>"
  end
  
  
end
