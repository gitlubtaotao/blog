module SessionsHelper
	#当登录的用户写入session中
	 def log_in(user)
    		session[:user_id] = user.id
  	end
       #
       def remember(user)
          user.remember
          cookies.permanent.signed[:user_id] = user.id
          cookies.permanent[:remember_token] = user.remember_token
       end

       #如果指定用户是当前用户，则返回true
       def current_user?(user)
          user == current_user
       end 

	# 定义当前用户
	 def current_user
              if (user_id = session[:user_id])
    		  @current_user ||= User.find_by(id: session[:user_id])
              elsif (user_id = cookies.signed[:user_id])
                 user = User.find_by(id:user_id)
                 if user && user.authenticated?(:remember, cookies[:remember_token])
                    log_in user
                    @current_user = user
                  end
                end 
  	end
	# 
	 def logged_in?
    		!current_user.nil?
  	end 

      #忘记持久辉煌会话
      def forget(user)
          user.forget
          cookies.delete(:user_id)
          cookies.delete(:remember_token)
      end
      #推出当前用户
  	def  log_out
              forget(current_user)
  		session.delete(:user_id)
  		@current_user =nil
  		
  	end
    #重定向到存储地址，或者默认地址
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end
    #存储以后需要获取的地址
    def store_location
      
      session[:forwarding_url] = request.url  if  request.get?
    end 

end
