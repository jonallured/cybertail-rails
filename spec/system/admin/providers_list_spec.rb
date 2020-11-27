require 'rails_helper'

describe 'Providers list page' do
  before do
    FactoryBot.create_list(:provider, provider_count)
  end

  context 'with no providers' do
    let(:provider_count) { 0 }

    it 'draws an empty list' do
      visit '/admin/providers'
      expect(page).to have_content 'Providers'
      expect(page).to_not have_css('li')
    end
  end

  context 'with a few providers' do
    let(:provider_count) { 3 }

    it 'shows those providers' do
      visit '/admin/providers'
      expect(page).to have_css('li', count: 3)
    end
  end

  context 'with a bunch of providers' do
    let(:provider_count) { 30 }

    it 'shows the first 10 providers' do
      visit '/admin/providers'
      expect(page).to have_css('li', count: 10)
    end
  end
end
