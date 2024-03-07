Rails.application.routes.draw do
  get 'blogs/index'
  get 'blogs/create'
  get 'blogs/update'
  get 'blogs/destroy'
  get '/', to: 'home#index'
end
