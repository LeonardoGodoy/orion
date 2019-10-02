module FormConcern
  extend ActiveSupport::Concern
  include ActiveModel::Model

  included do
    def perform; end

    def perform!
      ActiveRecord::Base.transaction do
        perform
        raise ActiveRecord::Rollback if errors.any?
        true
      end
    end

    def capture_errors(object)
      object.errors.each do |attribute, error|
        self.errors.add(attribute, error)
      end
    end
  end
end
