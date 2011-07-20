namespace :noladex do

  desc "Ensure all users have perisbale token ..."
  task :assign_random_password => :environment do
    User.all.each do |u|
      p "sending reset mail to #{u.email}"
      PasswordMailer.password_reset(u.email, u.perishable_token).deliver
      u.password = rand(0xffffff).to_s(16)
      u.save!
    end
  end

end