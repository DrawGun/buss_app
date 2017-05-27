module ActiveAdmin
  module FilterSaver
    module Controller
      private

      def restore_search_filters
        if params[:action].to_sym == :index && session[:activeadmin_return_to]
          if params[:controller] == session[:activeadmin_return_to][:controller]
            redirect_to session.delete(:activeadmin_return_to)[:link]
          else
            session.delete(:activeadmin_return_to)
          end
        end
      end

      def save_search_filters
        if params[:action].to_sym == :edit
          session[:activeadmin_return_to] ||= { link: request.referer, controller: params[:controller] }
        end
      end
    end
  end
end
