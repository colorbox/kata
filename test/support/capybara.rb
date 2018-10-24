require 'capybara'

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[no-sandbox headless disable-gpu])
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end


Capybara.configure do |config|
  config.javascript_driver = :chrome

  config.save_path = "#{Rails.root}/tmp/capybara"
end
