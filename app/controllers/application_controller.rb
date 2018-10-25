class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  protected
    def after_sign_in_path_for(resource)
<<<<<<< HEAD
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end
  end
=======
      request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    end



end
>>>>>>> 9fd97a682fd301973d6c918eb35b7f96adeeac68
