class Author < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable ,:omniauthable

  has_attached_file :author_pic, styles: { medium: "330x300>", thumb: "150x112>", small: "45x45" }, :default_url => "/assets/missing_avatar.jpg"
  validates_attachment_content_type :author_pic, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  has_many :comments, :dependent => :destroy
  has_many :articles, :dependent => :destroy

  validates :username, presence:true
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  # :recoverable, :rememberable, :trackable, :validatable ,:omniauthable
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.author

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = Author.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?

        user =Author.new(
          username: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : auth.extra.raw_info.email,
          password: Devise.friendly_token[0,20],
          author_pic: process_uri(auth.info.image)
          )

        # user.skip_confirmation! 
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.author != user
      identity.author = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
  def self.process_uri(uri)
   avatar_url = URI.parse(uri)
   avatar_url.scheme = 'https'
   avatar_url
   avatar_url.to_s

 end
# def remember_me
#   true
# end

end
