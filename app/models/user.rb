class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  				  :first_name, :last_name, :profile_name 
  # attr_accessible :title, :body

  has_many :statuses

  def full_name 
  	first_name + " " + last_name

  end

    def gravatar_url
      stripped_email = email.strip
      downcase_email = stripped_email.downcase
      hash = Digest::MD5.hexdigest(downcase_email)

      "http://gravatar.com/avatar/#{hash}"
end

end