class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :admin_user,     only: :destroy
  before_action :correct_user,    only: [:edit,  :update]#用户只能修改自己的信息

  def new
  	@user =User.new
  end
#分页显示所有的用户
  def index
     @users = User.paginate(page: params[:page])
  end 
#显示用户信息与用户的微博
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

#创建用户
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
  #编辑用户
  def edit
    @user = User.find(params[:id])
  end  

  #保存用户
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

    #删除用户
    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_url
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
      #显示用户自己的信息
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
    end
    #确保是管理员
    def admin_user

         redirect_to(root_url) unless current_user.admin?
          
        end
    
   

end
