module Api
  module V1
    class ApiController < ApplicationController
      respond_to :json
      before_filter :set_cache_buster
      before_filter :require_user
      skip_before_filter :verify_authenticity_token

      def set_cache_buster
        response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
        response.headers["Pragma"] = "no-cache"
        response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
      end

    end
  end
end
