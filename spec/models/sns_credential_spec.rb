RSpec.describe SnsCredential, type: :model do
  require 'rails_helper'

  describe 'Association' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'user' do
      let(:target) { :user}
      it { expect(association.macro).to eq :belongs_to }
      it { expect(association.class_name).to eq 'User' }
    end
  end
end