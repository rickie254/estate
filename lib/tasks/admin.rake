namespace :admin do
  desc "TODO"
  task create_admin: :environment do
    if Rails.env.production?
      Admin.create(email: "bruno@zordanimoveis.com.br", password: "prosite")
    else
      Admin.create(email: "teste@teste.com", password: "G0rila")
    end
  end

end
