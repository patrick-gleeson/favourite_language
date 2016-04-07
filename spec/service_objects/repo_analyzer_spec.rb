require 'spec_helper'
require_relative '../../app/service_objects/repo_analyzer'

RSpec.describe RepoAnalyzer do
  describe '#favourite_language' do
    before(:each) do
      stub_const('NoReposError', StandardError.new)
    end

    subject { RepoAnalyzer.new }

    it 'uses frequency to determine favourite' do
      repo_array = [
        { 'language' => 'VB6' },
        { 'language' => 'Ruby' },
        { 'language' => 'Ruby' },
        { 'language' => 'Ruby' },
        { 'language' => 'Java' },
        { 'language' => 'C#' }
      ]

      expect(subject.favourite_language(repo_array)).to eq 'Ruby'
    end

    it 'errors if no data' do
      repo_array = []

      expect { subject.favourite_language(repo_array) }
        .to raise_error NoReposError
    end

    it 'acts sensibly if two languages equally popular' do
      repo_array = [
        { 'language' => 'PHP' },
        { 'language' => 'Ruby' },
        { 'language' => 'Ruby' },
        { 'language' => 'Java' },
        { 'language' => 'Java' },
        { 'language' => 'C#' }
      ]

      expect(%w(Ruby Java)).to include subject.favourite_language(repo_array)
    end

    it 'handles repos with undefined languages' do
      repo_array = [
        { 'language' => 'PHP' },
        { 'language' => 'Ruby' },
        { 'language' => 'Ruby' },
        { 'language' => nil },
        { 'language' => 'Java' },
        { 'language' => 'C#' }
      ]

      expect(subject.favourite_language(repo_array)).to eq 'Ruby'
    end
  end
end
