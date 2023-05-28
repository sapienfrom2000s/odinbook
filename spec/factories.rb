
FactoryBot.define do
    factory :user1 do
      name { "John" }
      email { "#{name}@example.com" }
      password { "password" }
    end

    factory :user2 do
        name { "Unjohn" }
        email { "#{name}@example.com" }
        password { "password" }
    end
end