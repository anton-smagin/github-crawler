# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe '#index' do
    it 'searches for repositories based on the search term' do
      VCR.use_cassette('search_repositories') do
        get :index, params: { search_term: 'ruby' }

        expect(response).to have_http_status(:ok)
        expect(assigns(:repositories)).not_to be_nil
        expect(assigns(:repositories).size).to be_positive
      end
    end

    it 'does not search for repositories if search term is blank' do
      get :index, params: { search_term: '' }

      expect(response).to have_http_status(:ok)
      expect(assigns(:repositories)).to be_empty
    end
  end
end
