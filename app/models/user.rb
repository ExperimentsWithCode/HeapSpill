class User < ActiveRecord::Base

  attr_reader :password
  attr_reader :confirm

  validates :username, :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: {minimum:6, allow_nil: true }

  has_many(
  :questions,
  class_name: "Question",
  foreign_key: :author_id,
  primary_key: :id
  )


  has_many(
  :answers,
  class_name: "Answer",
  foreign_key: :question_id,
  primary_key: :id
  )

  has_many(
  :votes,
  class_name: "Vote",
  foreign_key: :user_id,
  primary_key: :id
  )

  def password_equals_confirm
    if self.password != self.confirm
      errors.add(:confirm, "Must match password")
    end
  end


  def self.find_by_credentials username, password
    user = User.find_by(username: username)
    return nil unless user
    user.password_is?(password) ? user : nil
  end

  def password= password
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

	def password_is? password
		BCrypt::Password.new(self.password_digest).is_password?(password)
	end

	def reset_session_token!
		self.session_token = new_session_token
		ensure_session_token_uniqueness
		self.save
		self.session_token
	end

	private

	def ensure_session_token
		self.session_token ||= new_session_token
	end

	def new_session_token
		SecureRandom.base64
	end

	def ensure_session_token_uniqueness
		while User.find_by(session_token: self.session_token)
			self.session_token = new_session_token
		end
	end
end
