class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :sns_credentials, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  # ↓お気に入りした投稿一覧を表示するために記述
  has_many :favorite_posts, through: :favorites,source: :post
  has_many :follow, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  # ↓フォロー一覧、フォロワー一覧を表示するために記述
  has_many :following_user, through: :follower, source: :follow
  has_many :follower_user, through: :follow, source: :follower
  # ↓refileの導入用記述
  attachment :profile_image, destroy: false
  # ↓enum用記述
  enum gender:['女性','男性','どちらでもない']
  enum age:['10代','20代','30代','40代','50代以上']

  validates :nickname, presence: true, length: {in: 2..15}
  validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :introduction, length: {maximum:50}

  # 特定条件のユーザーをログインさせない
  def active_for_authentication?
    super && validity?
  end

  # ログインできないときのメッセージ
  def inactive_message
    validity? ? super : :account_locked
  end

  # ユーザーのフォロー
  def followed(user_id)
    follower.create(follow_id: user_id)
  end
  # フォローを外す
  def unfollow(user_id)
    follower.find_by(follow_id: user_id).destroy
  end
  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  # ユーザー検索
  def self.search(search, user_or_post)
    User.where(['nickname LIKE?',"%#{search}%"])
  end

  # Omniauth login
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0, 20]
      user.nickname = auth.info.name
      user.profile_image = auth.info.image
    end
  end
end
