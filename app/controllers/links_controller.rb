class LinksController < ApplicationController
  before_action :load_link, only: [:redirect]

  def create
    @long_url = params['long_url']
    @custom_url = params['custom_url']

    if @custom_url.present?
      @short_url = custom_url
      if Link.exists?(custom_url: @custom_url)
        render json: { error: "Custom URL is already taken" }, status: :bad_request
        return
      end
    else
      @short_url = generate_short_url
    end

    render json: {
      message: "Short URL created successfully",
      short_url: @short_url
    }, status: :ok
  end

  def redirect
    @link.increment!(:clicks)
    redirect_to @link.long_url
  end

  private

  def generate_short_url
    short_code = SecureRandom.hex(4)
    base_url = "http://127.0.0.1:3000/"
    short_url = base_url + short_code
    create_link_record(short_url)

    short_url
  end

  def custom_url
    "http://127.0.0.1:3000/#{@custom_url}"
  end

  def create_link_record(short_url)
    Link.create(
      long_url: @long_url,
      short_url: short_url,
      custom_url: @custom_url
    )
  end

  def load_link
    @short_code = params["short_code"]
    @link = Link.find_by(short_url: "http://127.0.0.1:3000/#{@short_code}")

    render json: { error: "Short URL not found" }, status: :not_found unless @link
  end
end
