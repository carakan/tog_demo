require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase

  context "A visitor" do

    context "that signs up" do
      setup do
        @chavez = Factory(:user, :login => 'chavez')
      end

      should "be in state pending" do
        assert @chavez.state, "pending"
      end
          
      should "generate an activation_code" do
        assert_not_nil @chavez.activation_code
      end
    
      should "receive an email with a link to activation" do
        assert_sent_email do |email|
          email.body.include? @chavez.activation_code
          email.subject.include?(I18n.t("tog_user.mailer.activate_account"))
        end
      end
      
      context "that activates his acount" do
        setup do
          @chavez.activate!
        end

        should "be in state active" do
          assert @chavez.state, "active"
        end

        should "receive a welcome message" do
          assert_sent_email do |email|
            email.subject.include?(I18n.t("tog_user.mailer.account_activated"))
          end
        end

      end      
    
    end
  end
  
  context "A User" do

    setup do
      @chavez = Factory(:user, :login => 'chavez')
      @chavez.activate!
    end

    context "that has forgotten his password" do
      setup do
        @chavez.forgot_password
      end
    
      should "generate a password_reset_code" do
        assert_not_nil @chavez.password_reset_code
      end
    
      should "receive an email with a link to reset the password" do
        assert_sent_email do |email|
          email.body.include? @chavez.password_reset_code
          email.subject.include?(I18n.t("tog_user.mailer.reset_password"))
        end
      end
    
    end
  end

  context "Users" do
    setup do 
      User.destroy_all
      now = Time.now
      @user1 = Factory(:user, :login => 'user1', 
                              :email => 'user1@server.org',
                              :created_at => now)
      @user1.activate!                            
      @user2 = Factory(:user, :login => 'user2', 
                              :email => 'user2@server.org',
                              :created_at => now - 2.days)
      @user2.activate!
      @user2.suspend!                            
      @user3 = Factory(:user, :login => 'user3', 
                              :email => 'user3@otherserver.org',
                              :created_at => now - 15.days)
    end
    
    should 'be scoped by state' do
      assert_set_equal [@user1], User.state(:active)
      assert_set_equal [@user2], User.state(:suspended)
      assert_set_equal [@user3], User.state(:pending)
      assert_set_equal [@user1, @user2, @user3], User.state(nil)
    end
        
    should 'be scoped by text search (login and email)' do
      assert_set_equal [@user1, @user2, @user3], User.search('user')
      assert_set_equal [@user1], User.search('user1')
      assert_set_equal [@user3], User.search('otherserver')
      assert_set_equal [@user1, @user2], User.search('@server.org')
      assert_set_equal [@user1, @user2, @user3], User.search("")
      assert_set_equal [@user1, @user2, @user3], User.search(nil)
    end
    
    should 'be scoped by age (today, week, month)' do
      assert_set_equal [@user1], User.aged(:today)
      assert_set_equal [@user1, @user2], User.aged(:week)
      assert_set_equal [@user1, @user2, @user3], User.aged(:month)
      assert_set_equal [@user1, @user2], User.aged(:month, Time.now + 20.days)
      assert_set_equal [], User.aged(:month, Time.now - 1.year)
      assert_set_equal [@user1, @user2, @user3], User.aged(nil, Time.now + 1.year)
    end
  end
end
