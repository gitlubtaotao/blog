require 'test_helper'

class UserTest < ActiveSupport::TestCase
  has_many  :microposts
	def setup
		@user = User.new(name:  "Example", email: "user@example.com",
				      password: "foobar", password_confirmation: "foobar")
	end
	test "should be valid" do
		assert @user.valid?
	end
	test "name should be present" do
		@user.name="       "
		assert_not @user.valid?
	end 
	#add emails prsent
	test  "test should be present" do
		@user.email = "     "
		assert_not @user.valid?
	end 

	#add name should not be to long
	test "name should not be to long" do
		@user.name = "a" * 51
		assert_not @user.valid?
	end 
	test "email should not be to long " do
		@user.email = "a"  *244 +"@example.com"
		assert_not @user.valid?
	end 
	#add email valid
	 test "email validation should accept valid addresses" do
    		valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         				first.last@foo.jp alice+bob@baz.cn]
    		valid_addresses.each do |valid_address|
      		@user.email = valid_address
      		assert @user.valid?, "#{valid_address.inspect} should be valid"
    	end
    	# email unique
    	test "email addresses shoudle be unique" do
    		duplicate_user = @user.dup
    		duplicate_user.email = @user.email.upcase
    		@user.save
    		assert_not duplicate_user.valid?
    	end 
    	#password
    	 test "password should be present (nonblank)" do
    		@user.password = @user.password_confirmation = " " * 6
    		assert_not @user.valid?
  	end

  	test "password should have a minimum length" do
   		 @user.password = @user.password_confirmation = "a" * 5
    		assert_not @user.valid?
  	end
  	 test "authenticated? should return false for a user with nil digest" do
    		assert_not @user.authenticated?(:remember, '')
  	end
        #测试关注用户相关的辅助方法
        test "should follow and unfollow a user" do
              michael = users(:michael)
              archer = users.(:archer)
              assert_not michael.following?(archer)
              michael.follow(archer)
              assert michael.following?(archer)
              assert archer.followers.include?(michael)
              michael.unfollow(archer)
              assert_not michael.following?(archer)

        end
end


  # test "the truth" do
  #   assert true
  # end

