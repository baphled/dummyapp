module QuikCV
  class User
    include Mongoid::Document
    include Mongoid::Timestamps
    
    store_in :users
    
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable, :lockable and :timeoutable
    devise :database_authenticatable, :registerable, :token_authenticatable,
      :recoverable, :rememberable, :trackable, :validatable, :omniauthable

    field :username
    field :email
  end
end
