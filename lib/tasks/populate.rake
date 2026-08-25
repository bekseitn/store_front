# frozen_string_literal: true

namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    require 'faker'

    # Was using the `populator` gem (abandoned, and its PostgreSQLAdapter
    # monkeypatch turned out to break ActiveRecord's db:create/create_database
    # under Rails 7.2 - found by actually running the upgraded app). Plain
    # Ruby loop instead; also fixes a pre-existing bug where category_id
    # was assigned a whole Category record instead of its id.
    category_ids = Category.pluck(:id)

    100.times do
      Product.create!(
        name: Faker::Commerce.product_name,
        price: Faker::Commerce.price,
        category_id: category_ids.sample,
        active: true
      )
    end
  end
end
