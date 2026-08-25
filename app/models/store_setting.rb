# frozen_string_literal: true

class StoreSetting < ApplicationRecord
  validates :store_name, :currency, presence: true
  validate :only_one_record, on: :create

  def self.current
    first || create!
  end

  private

  def only_one_record
    errors.add(:base, 'Store settings already exist') if self.class.exists?
  end
end
