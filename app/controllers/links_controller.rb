class LinksController < ApplicationController

    def create
        @long_url = params['long_url']
        render json: {
            :message => "short_url created successfully",
            :short_url => generate_short_url
            }, status: :ok
    end

    def redirect
        
    end

    private
    def generate_short_url
        local_long_url = Link.find_by(long_url: @long_url)
        if local_long_url
            return local_long_url.short_url
        end

        short_code = SecureRandom.hex(4)
        base_url = "http://127.0.0.1:3000/"
        @short_url = base_url + short_code
        my_new_url=Link.new(
            long_url: @long_url,
            short_url: @short_url)
        my_new_url.save
        
        my_new_url.short_url
    end

end

