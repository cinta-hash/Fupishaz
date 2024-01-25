class Link < ApplicationRecord
    validates :long_url, presence: true
    validates :short_url, presence: true
    validates :short_url, uniqueness: true
    validates :custom_url, uniqueness: true
    validates :long_url, format: URI::regexp(%[http https])
    validates :custom_url, length: { maximum: 7 }, allow_blank: true

    after_initialize :init

    def init
        self.clicks ||= 0
    end
end
