class LinksController < ApplicationController

    def create
        @long_url = params['long_url']
        @short_url = generate_short_url
        render json: {
            :message => "short_url created successfully",
            :short_url => @short_url
            }, status: :ok
    end

    private
    def generate_short_url
        short_code = Base64.urlsafe_encode64(@long_url)[0..6]
        base_url = "http://127.0.0.1:3000/"
        base_url + short_code
    end

end

