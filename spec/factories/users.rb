FactoryBot.define do
  factory :user do
    id                    {1}
    nickname              {"ヤマ"}
    email                 {"aaaa@gmail.com"}
    password              {"aaaaaaaa"}
    first_name            {"山田"}
    family_name             {"彩"}
    first_name_kana       {"ヤマダ"}
    family_name_kana        {"アヤ"}
    birthday              {"2000/01/01"}
  end
end