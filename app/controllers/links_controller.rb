class LinksController < ApplicationController

    def create
        @link = Link.new(link_params)
        if @link.save
          render json: {short_url: @link.short_url}, status: :created
        else
          render json: {errors: @link.errors}, status: :unprocessable_entity
        end
      end

    def show
        @link = Link.find(params[:id])
       
    end

    def redirect 
        @link = Link.find_by(short_url: params[:short_url])
        if @link.nil?
          render json: {error: "No link found with the provided Short URL"}, status: :not_found
        else
          @link.update_attribute(:clicks, @link.clicks + 1)
          redirect_to @link.long_url, status: :found
        end
      end

    private

    def link_params
        params.require(:link).permit(:long_url, :custom_url)
    end

    def generate_short_url
        Base64.urlsafe_encode64(@link.long_url)[0..6]
    end

end

