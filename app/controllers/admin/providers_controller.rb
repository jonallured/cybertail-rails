module Admin
  class ProvidersController < AdminController
    expose(:providers) { Provider.order(:created_at).limit(10) }
  end
end
