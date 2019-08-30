FactoryBot.define do
  factory :pokemon do
    id { 4 }
    name { 'Charmander' }
    height { 6 }
    weight { 85 }
    shape { 'Upright' }
    capture_rate { 17.65 }
  end
end
