require 'rails_helper'

describe ItemsController do
  describe 'GET #new' do
    it "new.html.hamlに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #search' do
    context "search.html.erbに遷移すること" do
      specify do
        @params = Hash.new
        @params[:q] = Hash.new
        @params[:q][:name_has_every_term] = 'キーワード'
        get :search, params: @params
        expect(response).to render_template :search
      end
    end
  end
end