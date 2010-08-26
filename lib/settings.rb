module VkontakteAuthentication

  module Settings
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
end