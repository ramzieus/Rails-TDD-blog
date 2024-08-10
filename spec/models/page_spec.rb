require 'rails_helper'

RSpec.describe Page, type: :model do
  subject { build(:page) }

  describe 'validations' do
    it { is_expected.to be_valid }
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

  describe 'scopes' do
    describe '.published' do
      let(:page1) { create(:page, :published) }
      let(:page2) { create(:page) }
      before do
        [page1, page2]
      end
      it 'returns only published pages' do
        expect(Page.published).to eq([page1])
      end
    end
  end

end
