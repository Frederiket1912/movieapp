require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1600, 1080], options: {
    url: "http://localhost:4444/wd/hub",
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w[headless window-size=1600x1080] },
    )
  }
  def setup
    Capybara.server_host = "0.0.0.0"
    Capybara.server = :puma, { Threads: "1:1" }
    Capybara.app_host = "http://host.docker.internal:#{Capybara.current_session.server.port}"
    host! "http://host.docker.internal:#{Capybara.current_session.server.port}"
    super
  end
end
