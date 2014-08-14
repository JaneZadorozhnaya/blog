class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  scope :by_article, ->(id) { where(article_id: id) if id.present? }
end
