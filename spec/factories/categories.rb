FactoryBot.define do
  factory :parent, class: Category do
    id        {1}
    name      {"レディース"}
    ancestry  {nil}
  end
  factory :child, class: Category do
    id        {2}
    name      {"トップス"}
    ancestry  {1}
  end
  factory :category do
    id        {3}
    name      {"Tシャツ/カットソー（半袖/袖なし）"}
    ancestry  {1/2}
  end
end