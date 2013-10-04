# By using the symbol ':user', we get Factory Girl to simulate the User model.
FactoryGirl.define do

  factory :user do
    name                    "Michael Hartl"
    email                    "mhartl@example.com"
    password                 "foobar"
    password_confirmation   "foobar"
    admin                    false
  end

  factory :wod do
    name      "Fran"
    desc      "21-15-9 Thrusters, Pullups"
    seq        "WG"
    wod_type  "Time"
    baserep    1
  end

  factory :daywod do
    performed    "1/1/2013"
    association    :wod
  end

  factory :result do
    recd      1
    association    :daywod
    association    :user
  end
end