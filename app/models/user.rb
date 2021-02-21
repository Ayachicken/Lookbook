class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         # :validatable, <= メールアドレスを一意にすると引っかかるためコメントアウト
         :omniauthable, omniauth_providers: %i[google_oauth2]

  scope :without_soft_deleted, -> { where(deleted_at: nil) }

  #validatableに代わる検証
  validates_uniqueness_of :email, scope: :deleted_at
  validates_format_of :email, with: Devise.email_regexp, if: :will_save_change_to_email?
  validates :password, presence: true, confirmation: true, length: { in: Devise.password_length }, on: :create
  validates :password, confirmation: true, length: { in: Devise.password_length }, allow_blank: true, on: :update

  # @see https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    self.without_soft_deleted.where(conditions.to_h).first
  end

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

  #↓3つのメソッドはユーザーデータの論理削除
  #deleted_atカラムをタイムスタンプで更新
  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  #ユーザーアカウントが有効であるか確認
  def active_for_authentication?
    super && !deleted_at
  end

  #削除したユーザーにカスタムメッセージを追加
  def inactive_message
    !deleted_at ? super : :deleted_account
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
