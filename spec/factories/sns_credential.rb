FactoryBot.define do
  factory :sns_credential do
    provider {"facebook"}
    uid {"12345678"}
  end
end