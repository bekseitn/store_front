# frozen_string_literal: true

RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  config.model 'OrderItem' do
    object_label_method do
      :product_name
    end
  end

  config.model 'Product' do
    object_label_method do
      :name
    end
  end

  config.model 'City' do
    object_label_method do
      :name
    end
  end

  config.model 'Category' do
    object_label_method do
      :name
    end
  end

  config.model 'OrderStatus' do
    object_label_method do
      :name
    end
  end

  config.model 'Ordering' do
    object_label_method do
      :name
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
