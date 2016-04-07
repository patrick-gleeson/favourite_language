require 'spec_helper'
require_relative '../../app/service_objects/favourite_language_finder'

RSpec.describe FavouriteLanguageFinder do
  describe '#find_favourite_language' do
    let(:username) { 'patrick-gleeson' }
    let(:repo_array) { [] }
    let(:language) { 'Ruby' }
    let(:client) { double :client }
    let(:analyzer) { double :analyzer }
    let(:result) { double :language_check_attempt }

    subject { FavouriteLanguageFinder.new.find_favourite_language username }

    before(:each) do
      stub_const('GitHubClient', Class.new)
      stub_const('RepoAnalyzer', Class.new)
      stub_const('LanguageCheckAttempt', Class.new)

      LanguageCheckAttempt.class_eval { def initialize(arg); end }

      allow(GitHubClient).to receive(:new).and_return(client)
      allow(RepoAnalyzer).to receive(:new).and_return(analyzer)
      allow(analyzer).to receive(:favourite_language).with(repo_array)
        .and_return(language)
    end

    context '(when no error is thrown)' do
      it 'uses client and analyzer to make successful LanguageCheckAttempt' do
        expect(client).to receive(:repo_array).with(username)
          .and_return(repo_array)
        expect(LanguageCheckAttempt).to receive(:new)
          .with(successful: true, favourite_language: language)
          .and_return result

        expect(subject).to eq result
      end
    end

    context '(when an error is thrown)' do
      let(:error) { StandardError.new }

      it 'uses client and analyzer to make failed LanguageCheckAttempt' do
        expect(client).to receive(:repo_array).with(username)
          .and_raise(error)
        expect(LanguageCheckAttempt).to receive(:new)
          .with(successful: false, error: error)
          .and_return result

        expect(subject).to eq result
      end
    end
  end
end
