class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :token, :email, :user_type
end
