require "settings"

module VkontakteAuthentication  
  module Helper
    include Settings

    def vkontakte_init_tag
      content_tag(:div, "", :id => "vk_api_transport") +
      content_tag(:script, "init(#{vk_app_id});")            
    end

    def vkontakte_javascript_include_tag
      javascript_include_tag "vkontakte"
    end

    def vk_login_button
      content_tag(:div, "", {:id => "vk_login", :onclick => "doLogin();"})
    end
  end
end