FactoryBot.define do
  
  factory :item do
    name                  {"picture"}
    description           {"morinoe"}

    after(:build) do |item|
      parent = create(:category, name: "親", parent_id: nil)
      child = create(:category, name: "子", parent_id: parent.id)
      grand_child = create(:category, name: "孫", parent_id: child.id)
      item.category_id = grand_child.id
    end
    
    category_id           {3}
    seller_id             {1}
    buyer_id              {2}
    brand                 {"france"}
    condition_id          {1}
    postage_id            {2}
    shipping_method_id    {1}
    prefecture_id         {2}
    preparation_period_id {1}
    price                 {1000}

    after(:build) do |item|
      item.item_images << build(:item_image)
    end
  end
end