FactoryBot.define do
  
  factory :item do
    name                    {"itemA"}
    description             {"It's beautiful item"}
    brand                   {"brandA"}
    price                   {1000}
    seller_id               {1}
    buyer_id                {2}
    condition_id            {1}
    postage_id              {1}
    prefecture_id           {1}
    preparation_period_id   {1}
    shipping_method_id      {1}
    category_id             {}
    created_at              {}
    updated_at              {}
    after(:build) do |item|
      parent_category = create(:category)
      child_category = parent_category.children.create(name: "hello")      
      grand_child_category = child_category.children.create(name: "world")

      item.category_id = grand_child_category.id
    end
  end

end