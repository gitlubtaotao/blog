class User < ActiveRecord::Base
  #删除用户时，需要删除用户对应的微博和关系，所以添加dependent: :destroy
  has_many  :microposts, dependent: :destroy
  #获取我关注的人
 has_many :active_relationships,  class_name:  "Relationship",
                                                            foreign_key: "follower_id",
                                                            dependent:   :destroy
  has_many  :following,  through:   :active_relationships,  source:  :followed

  #获取关注我的人
  has_many  :passive_relationships,  class_name:  "Relationship",
                                                                foreign_key:  "followed_id",
                                                                dependent:    :destroy
  has_many :followers,  through:  :passive_relationships, source:  :follower
  

  attr_accessor :remember_token,  :activation_token,  :reset_token
  before_save   :downcase_email#保存之前建国邮箱转化成小写字符
  before_create :create_activation_digest#创建新用户时进行邮件认证

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 },allow_nil: true
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  # 返回指定字符串的哈希摘要
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 返回一个随机令牌
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 为了持久会话，在数据库中记住用户
  def remember
    self.remember_token = User.new_token#获取随机令牌
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 如果指定的令牌和摘要匹配，返回 true
  def authenticated?(attribute,token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end


  # 忘记用户
  def forget
    update_attribute(:remember_digest, nil)
  end

    # 激活账户
    def activate
      update_attribute(:activated,      true) 
      update_attribute(:activated_at, Time.zone.now)
    end

    # 发送激活邮件
     def send_activation_email
        UserMailer.account_activation(self).deliver_now
     end


      # 设置密码重设相关的属性
  def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest,  User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
  end

       # 发送密码重设邮件

       def send_password_reset_email
          UserMailer.password_reset(self).deliver_now
       end

     # 如果密码重设超时失效了，返回 true
      def password_reset_expired?
        reset_at < 2.hours.ago
      end

      def feed
          following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
          Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
      end
      #关注另一个用户
      def  follow(other_user)
          active_relationships.create(followed_id:  other_user.id)
      end
      #取消关注另一个用户
      def unfollow(other_user)
        active_relationships.find_by(followed_id: other_user.id).destroy
      end
      #如果当前用户关注了指定的用户，则返回true
      def  following?(other_user)
        following.include?(other_user)
      end
        
     
  private
  # 把电子邮件地址转换成小写
    def downcase_email
      self.email = email.downcase
    end

    # 创建并赋值激活令牌和摘要
    def create_activation_digest
       self.activation_token  = User.new_token
       self.activation_digest = User.digest(activation_token)
    end 
  end