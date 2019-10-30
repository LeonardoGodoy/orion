class DeletePostClassificationForm
  include FormConcern

  attr_accessor :user_id, :post_id

  validates :classification, presence: true

  def perform
    return false if invalid?

    classification.destroy
  end

  def classification
    @classification ||= PostClassification.find_by(classification_params)
  end

  def classification_params
    { user_id: user_id, post_id: post_id }
  end
end
