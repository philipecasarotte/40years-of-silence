require 'test_helper'

class PagesControllerTest < ActionController::TestCase

  context "When a user sends the contact form" do
    setup do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      post :contact, 'contact' => {'name' => "Ricardo", 'email' => "ricardo@dburnsdesign.com", 'message' => 'Hello!'}
    end

    should "send contact e-mail" do
      assert_sent_email do |email|
        email.from.include?('ricardo@dburnsdesign.com') && email.subject =~ /Contact From/
      end
    end
    
    should_set_the_flash_to(/Your message was sent/i)
  end

end
