class LinksController < ApplicationController

    def create
        @link = Link.new(link_params)
        @link.short_url = link.custom_url.present? ? @link.custom_url: generate_short_url
        if @link.save
            render :show
        else 
            render json: @link.errors, status: :unprocessable_entity
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
            redirect_to @link.long_url, :custom_url
        end
    end

    private

    def link_params
        params.require(:link).permit(:long_url, custom_url)
    end

    def generate_short_url
        SecureRandom.urlsafe_base64(5)
    end

end

