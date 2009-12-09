User.destroy_all
users = Array.new
['admin', 'user', 'besucher', 'visitante', 'malandrin'].each do |u|
  user = User.new(
    :login => u, 
    :password => "#{u}.pass", 
    :password_confirmation => "#{u}.pass",
    :admin => u == "admin",
    :email => "#{u}@demo.toghq.com")
  user.register!
  user.activate!
  users << user
end
  
Group.destroy_all
['Tog developers', 'Tog users'].each do |g|
  group = Group.create(:name => g, :author => users[0], :private => false)
  group.activate!
  group.join(users[0], true)
  group.join(users[1]) if Time.now.to_i / 2 == 0
  group.join(users[2]) if Time.now.to_i / 2 == 0
  group.join(users[3]) if Time.now.to_i / 2 == 0
  group.join(users[4]) if Time.now.to_i / 2 == 0
end