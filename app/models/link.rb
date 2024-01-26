class Link < ApplicationRecord
    validates :long_url, presence: true
    validates :short_url, presence: true
    validates :short_url, uniqueness: true
    #validates :long_url, format: URI::regexp(%[http https])
    validates :custom_url, uniqueness: true, allow_nil: true

    after_initialize :init

    def init
        self.clicks ||= 0
    end
end
