FactoryBot.define do
  factory :item_image do
    id    {1}  
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/images/test.jpeg')) }
    item
  end
end