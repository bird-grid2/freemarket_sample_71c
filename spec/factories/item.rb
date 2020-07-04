FactoryBot.define do
  
  factory :item do
    name                    {"itemA"}
    description             {"It's beautiful item"}
    brand                   {"brandA"}
    price                   {1000}
    buyer_id                {2}
    condition_id            {1}
    postage_id              {1}
    prefecture_id           {1}
    preparation_period_id   {1}
    shipping_method_id      {1}
    seller_id               {1}
    created_at              {}
    updated_at              {}
    after(:build) do |item|
      parent = create(:category, name: "親", parent_id: nil)
      child = create(:category, name: "子", parent_id: parent.id)
      grand_child = create(:category, name: "孫", parent_id: child.id)
      item.category_id = grand_child.id
    end
  end

end