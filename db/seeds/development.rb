# db/seeds/development.rb

# users =User.create!(
#   [
#     { name: 'tatsumax', email: 'maoti@gmail.com', password: 'maomaomaoti', unique_user_id: 'tatsumax123', text: 'PersonalBoardを開発しています。' },
#     { name: 'Alice', email: 'alice@example.com', password: 'password', unique_user_id: 'alice123', text: '私はAliceです。' },
#     { name: 'Bob', email: 'bob@example.com', password: 'password', unique_user_id: 'bob123', text: '私はBobです。' },
#     { name: 'Carol', email: 'carol@example.com', password: 'password', unique_user_id: 'carol123', text: '私はCarolです。' }
#   ]
# )

# Link.create!(
#   [
#     { link_name: 'インスタグラム', link_url:'http://example.com/tatsumax', user: users[0], link_order: 1 },
#     { link_name: 'インスタグラム', link_url:'http://example.com/alice', user: users[1], link_order: 1 },
#     { link_name: 'インスタグラム', link_url:'http://example.com/bob', user: users[2], link_order: 1 },
#     { link_name: 'インスタグラム', link_url:'http://example.com/carol', user: users[3], link_order: 1 }
#   ]
# )

100.times do |i|
  User.create!(
    unique_user_id: "user_#{i}",
    name: "user_#{i}",
    email: "user_#{i}@example.com",
    password: "password",
    text: "Hello, world."
  )
end
