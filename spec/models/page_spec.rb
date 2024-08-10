require 'rails_helper'

RSpec.describe Page, type: :model do
  let(:page) { build(:page) }
  subject { build(:page) }

  it 'has a valid factory' do
    expect(page).to be_valid
  end

  describe 'validations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
  end

  describe '#slug' do
    let(:page) { create(:page, title: '--Foo Bar! _ 87 --') }
    it 'is generated from the title' do
      expect(page.slug).to eq('foo-bar-87')
    end
  end

end
