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

    describe '.ordered' do
      let(:page1) { create(:page, created_at: 2.days.ago) }
      let(:page2) { create(:page, created_at: 1.day.ago) }
      before do
        [page1, page2]
      end
      it 'returns ordered pages' do
        expect(Page.ordered).to eq([page2, page1])
      end
    end

    describe '.by_term' do
      let(:page1) { create(:page, content: 'foo') }
      let(:page2) { create(:page, content: 'foo bar') }
      let(:page3) { create(:page, content: 'foo bar baz') }

      before do
        [page1, page2]
      end

      it 'returns pages for the given term' do
        expected = [page1, page2, page3]
        expect(Page.by_term('foo')).to match_array(expected)
      end

      it 'returns pages for multiple terms' do
        expected = [page3]
        expect(Page.by_term('foo baz')).to match_array(expected)
      end
    end
  end

end
