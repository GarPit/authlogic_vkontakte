require "profile_loader"
require "md5"

module VkontakteAuthentication

  class NotInitializedError < StandardError;
  end


  def login_vkontakte(cookies)
    if (cookies[vk_app_cookie])
      vk_cookies = CGI::parse(cookies[vk_app_cookie])
      result = "expire=%smid=%ssecret=%ssid=%s%s" % [vk_cookies['expire'], vk_cookies['mid'], vk_cookies['secret'], vk_cookies['sid'], vk_app_password]
      MD5.md5(result).to_s == vk_cookies['sig'].to_s
    end
  end

  def vkontakte_authentication
    raise(NotInitializedError, "create and initialize vkontakte.yml") unless profile_loader.vkontakte_yml_defined? && vk_app_id && vk_app_password
  end

  private

    def profile_loader
      @profile_loader ||= ProfileLoader.new
    end

    def vk_app_id
      @vk_app_id ||= profile_loader.param(:vk_app_id)
    end

    def vk_app_password
      @vk_app_password ||= profile_loader.param(:vk_app_password)
    end

    def vk_app_cookie
      'vk_app_' + vk_app_id.to_s
    end

end

ActiveRecord::Base.send :extend, VkontakteAuthentication