require 'rails_helper'

RSpec.describe FavouriteLanguagesController, type: :controller do
  describe 'GET #show' do
    let(:finder) { double :finder }
    let(:result) { double :result }
    let(:username) { 'patrick-gleeson' }

    subject { get :show, username: username }

    before(:each) do
      expect(FavouriteLanguageFinder).to receive(:new).and_return(finder)
      expect(finder).to receive(:find_favourite_language)
        .with(username)
        .and_return(result)
    end

    context '(when successful)' do
      let(:language) { 'Ruby' }

      before(:each) do
        expect(result).to receive(:if_failed)
        expect(result).to receive(:if_successful).and_yield(language)
      end

      it 'assigns language and renders show' do
        expect(subject).to render_template(:show)
        expect(assigns(:favourite_language)).to eq(language)
      end
    end

    context '(when unsuccessful)' do
      let(:error_message) { 'Something went wrong' }

      before(:each) do
        expect(result).to receive(:if_successful)
        expect(result).to receive(:if_failed).and_yield(error_message)
      end

      it 'assigns error message and renders error' do
        expect(subject).to render_template(:error)
        expect(assigns(:error_message)).to eq(error_message)
      end
    end
  end
end
