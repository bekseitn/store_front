# frozen_string_literal: true

RailsAdmin.config do |config|
  ### Popular gems integration

  # /admin had no authentication at all - confirmed live, GET
  # /admin/product returned 200 with no challenge, so anyone with the
  # URL could edit or delete every record. No User model/sessions exist
  # in this app, so a full Devise setup would be a lot of new surface
  # area just to gate one mount point - HTTP Basic Auth on the engine
  # itself is the standard, minimal fix for exactly this shape of app.
  # Credentials are ENV-overridable (see database.yml for the same
  # pattern); change RAILS_ADMIN_PASSWORD before any real deployment -
  # the fallback below is a local-dev-only default, not a real secret.
  config.authenticate_with do
    authenticate_or_request_with_http_basic('Admin') do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(
        username, ENV.fetch('RAILS_ADMIN_USERNAME', 'admin')
      ) & ActiveSupport::SecurityUtils.secure_compare(
        password, ENV.fetch('RAILS_ADMIN_PASSWORD', 'changeme123')
      )
    end
  end
  config.current_user_method { nil }

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

  # StoreSetting is a singleton (see its own only_one_record validation) -
  # self.current auto-creates the one row if it's missing, so there's
  # never a real reason to show "new" or "delete" for it here.
  config.model 'StoreSetting' do
    object_label_method do
      :store_name
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['StoreSetting']
    end
    export
    bulk_delete
    show
    edit
    delete do
      except ['StoreSetting']
    end
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
