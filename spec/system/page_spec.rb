require 'rails_helper'
RSpec.describe 'Pages' do
  let(:my_page) { create(:page, :published) }
  it 'renders page' do
    visit page_path(slug: my_page.slug)
    article = find('article')
    within article do
      expect(page).to have_css('h2', text: my_page.title)
    end
  end

  describe '.month_year_list' do
    let(:result) { Page.month_year_list }
    before do
      create(:page, created_at: Date.new(2022, 7, 4))
      create(:page, :published, created_at: Date.new(2022, 8, 10))
      create(:page, :published, created_at: Date.new(2022, 8, 11))
      create(:page, :published, created_at: Date.new(2021, 3, 13))
    end

    it 'returns a list of results' do
      expect(result.count).to eq(2)
    end

    it 'returns month and year' do
      expect(result[0]['month_name']).to eq('August')
      expect(result[0]['month_number']).to eq('08')
      expect(result[0]['year']).to eq('2022')

      expect(result[1]['month_name']).to eq('March')
      expect(result[1]['month_number']).to eq('03')
      expect(result[1]['year']).to eq('2021')
    end
  end

  describe '.by_year_month' do
    let(:page1) { create(:page, created_at: Date.new(2022, 8, 10)) }
    let(:page2) { create(:page, created_at: Date.new(2021, 4, 13)) }
    before do
      [page1, page2]
    end
    it 'returns pages for the given year and month' do
      expect(Page.by_year_month(2021, 4)).to match_array([page2])
    end
  end
end