module Apotomo
  module Stateful
    module SimpleSessionEngine
      RequestProcessor.after_initialize do |rp|
        rp.root.each do |w|
          next unless w.respond_to?(:flavor)
          next unless w.parent_controller.session['_apotomo_simple_session']
          next unless w.parent_controller.session['_apotomo_simple_session'][w.name]
          
          w.flavor= w.parent_controller.session['_apotomo_simple_session'][w.name][:flavor]
        end
      end
      
      
      extend ActiveSupport::Concern
      
      included do |base|
        base.after_filter do
          
          widget_session = {}
          
          # FIXME: make generic, just a prototype.
          apotomo_root.each do |w|
            next unless w.respond_to?(:flavor)
            widget_session[w.name] = {:flavor => w.flavor}
          end
          
          session['_apotomo_simple_session'] = widget_session
        end
      end
      
    end
  end
end
