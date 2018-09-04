class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :sender, :created_at, :updated_at
end