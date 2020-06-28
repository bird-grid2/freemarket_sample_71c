require 'rails_helper'

RSpec.describe ItemImage, type: :model, do: true do
  before do
    @item = build(:item)
  end
  let(:image_path) { Rails.root.join('spec/images/test.jpeg') }
  let(:photo) { Rack::Test::UploadedFile.new(image_path) }

  describe '#create' do
    it '画像が空のままで登録されないこと' do
      item = @item
      image = build(:item_image, image: nil)
      image.valid?
      expect(image.errors[:image]).to include("を入力してください")
    end
    it '全項目入力で登録されること' do
      item = @item
      image = build(:item_image)
      expect(image).to be_valid
    end
  end
end
