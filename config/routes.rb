Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "welcome#index"
  #
  # resources :books, shallow: true, except: [:update, :edit] do
  #   resources :reviews, only: [:create, :new, :destroy]
  #   resources :authors, only: :show
  # end
  # resources :users, only: :show

  post 'books/:book_id/reviews', to: 'reviews#create', as: 'book_reviews'
  get 'books/:book_id/reviews/new', to: 'reviews#new', as: 'new_book_review'
  delete 'reviews/:id', to: 'reviews#destroy', as: 'review'

  get 'authors/:id', to: 'authors#show', as: 'author'
  get 'books', to: 'books#index', as: 'books'
  post 'books', to: 'books#create'
  get 'books/new', to: 'books#new', as: 'new_book'
  get 'books/:id', to: 'books#show', as: 'book'
  delete 'books/:id', to: 'books#destroy'
  get 'users/:id', to: 'users#show', as: 'user'


end
