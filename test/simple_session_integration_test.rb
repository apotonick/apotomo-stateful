require 'test_helper'

class MouseWidget < Apotomo::Widget
  attr_accessor :flavor
  
  responds_to_event :eat
  
  def display
    @flavor = "cheese"
    render :text => @flavor
  end
  
  def eat(evt)
    @flavor += "butter"
    render :text => @flavor
  end
  
end


class SimpleSessionIntegrationTest < ActionController::IntegrationTest
  context "Controller" do
    should "save stateful attributes in session after initial request without widget rendering #FIXME" do
      get "simple/index"
      
      assert_equal({'mum' => {:flavor=>nil}}, session['_apotomo_simple_session'])
    end
    
    should "save stateful attributes in session after initial request" do
      get "simple/dashboard"
      
      assert_equal({'mum' => {:flavor=>"cheese"}}, session['_apotomo_simple_session'])
    end
    
    should "restore and save stateful attributes in session, again" do
      get "simple/dashboard"
      assert_equal({'mum' => {:flavor=>"cheese"}}, session['_apotomo_simple_session'])
      
      get "simple/render_event_response", :source => "mum", :type => :eat
      assert_equal({'mum' => {:flavor=>"cheesebutter"}}, session['_apotomo_simple_session'])
    end
  end
end
