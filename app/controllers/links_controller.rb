class LinksController < ApplicationController
    before_action :load_link, only: [:redirect]
  
    def create
      @long_url = params['long_url']
      @custom_url = params['custom_url']
  
      if @custom_url.present?
        @short_url = custom_url
        unless Link.find_by(custom_url: @custom_url)
          create_link_record
        else
          render json: { :error => "Custom URL is already taken" }, status: :bad_request
          return
        end
      else
        @short_url = generate_short_url
      end
  
      render json: {
        :message => "Short URL created successfully",
        :short_url => @short_url
      }, status: :ok
    end
  
    def redirect
      @link.increment!(:clicks) # Increment the clicks count
      redirect_to @link.long_url, allow_other_host: true
    end
  
    private
  
    def generate_short_url
      local_long_url = Link.find_by(long_url: @long_url)
      return local_long_url.short_url if local_long_url
  
      short_code = SecureRandom.hex(4)
      base_url = "http://127.0.0.1:3000/"
      @short_url = base_url + short_code
      create_link_record
  
      @short_url
    end
  
    def get_url_by_short_code
      link_record = Link.find_by(short_url: "http://127.0.0.1:3000/#{@short_code}")
      link_record&.long_url
    end
  
    def custom_url
      "http://127.0.0.1:3000/#{@custom_url}"
    end
  
    def create_link_record
      my_new_url = Link.new(
        long_url: @long_url,
        short_url: @short_url,
        custom_url: @custom_url
      )
      my_new_url.save
    end
  
    def load_link
      @short_code = params["short_code"]
      @link = Link.find_by(short_url: "http://127.0.0.1:3000/#{@short_code}")
  
      render json: { :error => "Short URL not found" }, status: :not_found unless @link
    end
  end
  