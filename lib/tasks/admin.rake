namespace :admin do
  desc "TODO"
  task create_admin: :environment do
    if Rails.env.development?
      Admin.create(email: "teste@teste.com", password: "G0rila")
    else
      Admin.create(email: "bruno@zordanimoveis.com.br", password: "prosite")
    end
  end

end
