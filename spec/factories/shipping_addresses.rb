  
FactoryBot.define do
  factory :shipping_address do
    post_code      {"111-1111"}
    prefecture       {"東京都"}
    city             {"渋谷区"}
    block          {"渋谷1-1-1"}
    building        {"渋谷ビル101"}
    first_name            {"山田"}
    family_name             {"彩"}
    first_name_kana       {"ヤマダ"}
    family_name_kana        {"アヤ"}
  end
end