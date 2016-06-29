class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
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

  def edit
    @user = User.find(params[:id])
  end  
   def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 处理更新成功的情况
       flash[:success] = "Profile updated"
       redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  
def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  private
      def user_params
          params.require( :user).permit(:name, :email, :password, :password_confirmation)
      end 

end
