require 'selenium-webdriver'

Capybara.register_driver :remote_chrome do |app|
    options = Selenium::WebDriver::Options.chrome
    options.add_argument('--no-sandbox')
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--window-size=1680,1050')
    options.add_argument('--disable-features=Autofill,AutofillServerCommunication,PasswordManager')
    options.add_preference('credentials_enable_service', false)
    options.add_preference('profile.password_manager_enabled', false)
    options.add_preference('autofill.profile_enabled', false)
    options.add_preference('autofill.credit_card_enabled', false)
    Capybara::Selenium::Driver.new(
        app,
        browser: :remote,
        url: ENV['SELENIUM_DRIVER_URL'],
        capabilities: options
    )
end