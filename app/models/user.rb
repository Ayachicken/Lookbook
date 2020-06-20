class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
  enum age:['10代以下','20代','30代','40代','50代以上']
  enum validity:['Valid','Invalid']
end
