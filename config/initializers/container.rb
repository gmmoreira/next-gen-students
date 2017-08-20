require 'dry/system/container'

class AppContainer < Dry::System::Container
  configure do |config|
    config.root = (Pathname.pwd + 'app')

    config.auto_register = %w[ services ]
  end

  load_paths!('services')
end

AppImport = AppContainer.injector

AppContainer.finalize! if Rails.env == 'production'
