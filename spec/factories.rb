FactoryGirl.define do

  factory :user do
    name                    "Michael Hartl"
    email                    "mhartl@example.com"
    password                 "foobar"
    password_confirmation   "foobar"
    admin                    false
  end

  factory :bio do
    height 69
    weight 178
    experience "4 years"
    fav "none of them"
    unfav "burpees"
    association :user
  end

  factory :wod do
    name             "Fran"
    description      "21-15-9 Thrusters, Pullups"
    seq              "WG"
    wod_type         "Time"
    baserep           60
  end

  factory :daywod do
    performed    "1/1/2013"
    wod_id        1
  end

  factory :result do
    recd      1
    association    :daywod
    association    :user
  end
end
