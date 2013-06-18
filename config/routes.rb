# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

match 'faq/new', :to => 'faq#new', :via => 'get'
match 'faq/new', :to => 'faq#create', :via => 'post'
match 'faq/:id/edit', :to => 'faq#edit', :via => 'get'
match 'faq/:id/edit', :to => 'faq#update', :via => 'post'
match 'faq/:id', :to => 'faq#destroy', :via => 'post'

resources :faq