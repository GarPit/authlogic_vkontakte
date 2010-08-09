module VkontakteAuthentication

  class YmlLoadError < StandardError; end
  class NoSettingsError < StandardError; end

  class ProfileLoader

    def initialize
      @vkontakte_yml = nil
    end

    def vkontakte_yml_defined?
        vkontakte_file && File.exist?(vkontakte_file)
    end

    def param(key)
      vkontakte_yml[key.to_s]
    end

    private

      def vkontakte_yml
        return @vkontakte_yml if @vkontakte_yml
        unless vkontakte_yml_defined?
          raise(NoSettingsError,"vkontakte.yml was not found.\n")
        end

        require "yaml"

        begin
          @vkontakte_yml = YAML.load_file(vkontakte_file)
        rescue StandardError => e
          raise(YmlLoadError,"vkontakte.yml was found, but could not be parsed.\n")                    
        end
      end

      def vkontakte_file
        @vkontakte_file ||= Dir.glob('{,.config/,config/}vkontakte{.yml,.yaml}').first
      end
    
  end
end