class User < ApplicationRecord
  # ======================
  #   アソシエーション
  # ======================
  has_many :links, dependent: :destroy

  # ======================================================
  #   親モデルのフォーム内で子モデルを操作できるようにする設定
  # ======================================================
  accepts_nested_attributes_for :links, allow_destroy: true

  # ======================
  #   ActiveStorageの設定
  # ======================
  has_one_attached :image

  # ======================
  #   deviceのモジュール
  # ======================
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  # ======================
  #   バリデーション
  # ======================
  validates :unique_user_id, presence: true,
  uniqueness: true, length: { in: 6..16 },
              format: { with: /\A[a-zA-Z0-9_]+\z/,
                        message: "は英数字とアンダースコア(_)のみが使用できます" }
  validates :name, presence: true, length: { maximum: 18 }
  validate :password_validations, if: :password_change_required?
  validates :text, length: { maximum: 70 }, allow_blank: true
  validates :image, content_type: {
    in: %w[image/jpeg image/png],
    message: "の形式が対応していません"
  },
  size: {
    less_than: 5.megabytes,
    message: "サイズが5MBを超えてます"
  }

  # ======================
  #   カスタムメソッド
  # ======================

  # 画像のリサイズ
  def resized_image
    image.variant(resize_to_fill: [400, 400]).processed
  end
  after_save :remove_original_image, if: -> { image.attached? && image.metadata[:variant].present? }

  # ログイン時にトークンを生成
  def update_session_token
    self.update(session_token: SecureRandom.hex(10))
  end

  # ログアウト時にトークンをリセット
  def reset_session_token
    self.update(session_token: nil)
  end


  private

  def remove_original_image
    # リサイズ後の画像が生成された後に元の画像を削除
    image.purge if image.attached?
  end

  # パスワードのカスタムバリデーション
  def password_validations
    if password.blank?
      errors.add(:password, I18n.t('users.change_password.no_password'))
    elsif password.match(/\s/)
      errors.add(:password, I18n.t('users.change_password.include_space'))
    elsif !password.match?(/\A[a-zA-Z0-9]+\z/)
      errors.add(:password, I18n.t('users.change_password.invalid_characters'))
    end
  end

  def password_change_required?
    # パスワード変更が必要な場合にのみバリデーションを実行
    password.present? || password_confirmation.present?
  end

end
