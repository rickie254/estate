namespace :admin do
  desc "TODO"
  task create_admin: :environment do
    Admin.create(email: "teste@teste.com", password: "G0rila")
  end

end
