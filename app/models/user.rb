class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  				  :first_name, :last_name, :profile_name 
  # attr_accessible :title, :body

validates :first_name,presence:true 

validates :last_name,presence:true

validates :profile_name,presence:true,
                        uniqueness:true,
                        format:{
                          with: /[a-zA-Z0-9_-]+/,
                          message:'Must be formatted correctly.'
                        }



  has_many :statuses

  def full_name 
  	first_name + " " + last_name
  end
  

    def gravatar_url
      stripped_email = email.strip
      downcased_email = stripped_email.downcase
      hash = Digest::MD5.hexdigest(downcase_email)

      "http://gravatar.com/avatar/#{hash}"

    end

      def self.find_for_facebook_oauth(access_token,signin_in_resource=nil)
        data=access_token.extra.raw_info
        if user = User.where(:email =>data.email).first_user
        else
          User.create!(:email => data.email, :password => Devise.friendly_token[0,20])

        end 

    def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]
          ["raw_info"]
          user.email = data["email"]
        end
      end
    end
  end
end

