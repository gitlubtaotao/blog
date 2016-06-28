class UsersController < ApplicationController
  
  def new
  	@user =User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end


  def create
       #@user = User.new(params[:user]) 
       @user = User.new(user_params)
  	if @user.save
  		#success
              @user.send_activation_email
              flash[:info] = "Please check your email to activate your account."
              redirect_to root_url
        else
  		render 'new'
  	end 
  end
  

  private
      def user_params
          params.require( :user).permit(:name, :email, :password, :password_confirmation)
      end 

end
