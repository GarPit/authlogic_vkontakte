require "profile_loader"
require "settings"
require "md5"

module VkontakteAuthentication

  class NotInitializedError < StandardError;
  end

  module ClassMethods
    include Settings


    def login_vkontakte(cookies)
      if cookies[vk_app_cookie]
        vk_cookies = CGI::parse(cookies[vk_app_cookie])
        result = "expire=%smid=%ssecret=%ssid=%s%s" % [vk_cookies['expire'], vk_cookies['mid'], vk_cookies['secret'], vk_cookies['sid'], vk_app_password]
        if MD5.md5(result).to_s == vk_cookies['sig'].to_s
          raise(NotInitializedError, "you must define vk_id column in your User model") unless self.respond_to? :find_by_vk_id
          find_or_create_vk_authenticated(vk_cookies['mid'].first)
        end
      end
    end

    def vkontakte_authentication
      raise(NotInitializedError, "create and initialize vkontakte.yml") unless profile_loader.vkontakte_yml_defined? && vk_app_id && vk_app_password
    end    

    def find_or_create_vk_authenticated(mid_cookie)
      vk_authenticated = self.send :find_by_vk_id, mid_cookie
      if vk_authenticated.nil?
        vk_authenticated = self.new('vk_id' => mid_cookie)
        vk_authenticated.send :persistence_token=, Authlogic::Random.hex_token if vk_authenticated.respond_to? :persistence_token=
        vk_authenticated.send :save, false
      end
      vk_authenticated
    end

  end 

  module InstanceMethods

    def save(& block)
      result = nil
      self.record = attempted_record

      before_save
      new_session? ? before_create : before_update
      new_session? ? after_create : after_update
      after_save

      save_record
      self.new_session = false
      result = true

      yield result if block_given?
      result
    end

    private

    def destroy_vkontakte_cookies
      controller.cookies.delete self.class.vk_app_cookie
    end
  end
  

end

ActiveRecord::Base.class_eval do
  extend VkontakteAuthentication::ClassMethods
  attr_accessible :vk_id
end

Authlogic::Session::Base.class_eval do
  include VkontakteAuthentication::InstanceMethods
  extend VkontakteAuthentication::Settings
  after_destroy :destroy_vkontakte_cookies
end
