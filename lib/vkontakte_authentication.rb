require "profile_loader"
require "settings"
require "md5"

module VkontakteAuthentication

  class NotInitializedError < StandardError;
  end

  module ClassMethods
    include Settings    

    def find_by_vk_id_method(value = nil)
      rw_config(:find_by_vk_id_method, value, "find_by_vk_id")
    end
    alias_method :find_by_vk_id_method=, :find_by_vk_id_method

    def vk_id_field(value = nil)
      rw_config(:vk_id_field, value, :vk_id)
    end
    alias_method :vk_id_field=, :vk_id_field

    def vkontakte_authentication
      raise(NotInitializedError, "create and initialize vkontakte.yml") unless profile_loader.vkontakte_yml_defined? && vk_app_id && vk_app_password
    end
    
  end

  module InstanceMethods

    private

    def credentials=(value)
      super
      cookies = value.is_a?(Array) ? value.first : value
      if cookies && cookies[vk_app_cookie]
        @vk_cookies = CGI::parse(cookies[vk_app_cookie])        
      end
    end

    def authenticating_with_vkontakte?
      @vk_cookies
    end

    def validate_by_vk_cookie
      result = "expire=%smid=%ssecret=%ssid=%s%s" % [@vk_cookies['expire'], @vk_cookies['mid'], @vk_cookies['secret'], @vk_cookies['sid'], self.class.vk_app_password]
      if MD5.md5(result).to_s == @vk_cookies['sig'].to_s
        raise(NotInitializedError, "you must define vk_id column in your User model") unless record_class.respond_to? find_by_vk_id_method
        mid_cookie = @vk_cookies['mid'].first
        possible_record = search_for_record(find_by_vk_id_method, mid_cookie)
        if possible_record.nil?
          possible_record = record_class.new(vk_id_field => mid_cookie)
          possible_record.send :persistence_token=, Authlogic::Random.hex_token if possible_record.respond_to? :persistence_token=
          possible_record.send :save, false
        end
        self.attempted_record = possible_record
      end
    end

    def vk_app_cookie
      self.class.vk_app_cookie
    end

    def find_by_vk_id_method
      self.class.find_by_vk_id_method      
    end

    def vk_id_field
      self.class.vk_id_field
    end

    def record_class
      self.class.klass
    end

    def destroy_vkontakte_cookies
      controller.cookies.delete vk_app_cookie
    end
  end


end

ActiveRecord::Base.class_eval do
  extend VkontakteAuthentication::ClassMethods
  attr_accessible vk_id_field
end

Authlogic::Session::Base.class_eval do
  include VkontakteAuthentication::InstanceMethods
  extend VkontakteAuthentication::ClassMethods
  after_destroy :destroy_vkontakte_cookies
  validate :validate_by_vk_cookie, :if => :authenticating_with_vkontakte?
end
