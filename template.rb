# frozen_string_literal: true

if yes? 'Do you wish to generate a root controller? (y/n)'
  name = ask('What do you want to call it?').to_s.underscore
  generate :controller, "#{name} index"
  route "root to: '#{name}\#index'"
  route "resource :#{name}, controller: :#{name}, only: [:index]"
end

generate 'rspec:install'
