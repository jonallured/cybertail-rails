require 'rails_helper'

describe 'Raw Hooks list page' do
  before do
    FactoryBot.create_list(:raw_hook, raw_hook_count)
  end

  context 'with no hooks' do
    let(:raw_hook_count) { 0 }

    it 'draws an empty list' do
      visit '/admin/raw_hooks'
      expect(page).to have_content 'Raw Hooks'
      expect(page).to_not have_css('li')
    end
  end

  context 'with a few hooks' do
    let(:raw_hook_count) { 3 }

    it 'shows those hooks' do
      visit '/admin/raw_hooks'
      expect(page).to have_css('li', count: 3)
    end
  end

  context 'with a bunch of hooks' do
    let(:raw_hook_count) { 30 }

    it 'shows the first 10 hooks' do
      visit '/admin/raw_hooks'
      expect(page).to have_css('li', count: 20)
    end
  end
end
