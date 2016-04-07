require 'spec_helper'
require 'httparty'
require_relative '../../app/service_objects/git_hub_client'

RSpec.describe GitHubClient do
  describe '#repo_array' do
    before(:each) do
      %w(ConnectionError
         InvalidUsernameError
         UnrecognisedUsernameError
         StatusError).each do |error|
        stub_const(error, StandardError.new)
      end
    end

    let(:response_hash) { { 'some' => 'response' } }
    let(:username) { 'patrick-gleeson' }
    let(:url) { "https://api.github.com/users/#{username}/repos" }

    subject { GitHubClient.new }

    it 'returns JSON on successful request' do
      stub_request(:get, url)
        .to_return(status: 200, body: response_hash.to_json)

      ret = subject.repo_array(username)

      expect(ret).to eq response_hash
    end

    it 'disallows invalid usernames' do
      ['../weird_username', 'weird?', 'something#weird'].each do |invalid|
        expect { subject.repo_array(invalid) }
          .to raise_error(InvalidUsernameError)
      end
    end

    it 'handles 404s' do
      stub_request(:get, url).to_return(status: 404)
      expect { subject.repo_array(username) }
        .to raise_error(UnrecognisedUsernameError)
    end

    it 'handles other bad status codes' do
      stub_request(:get, url).to_return(status: 500)
      expect { subject.repo_array(username) }.to raise_error(StatusError)
    end

    it 'handles connection problems' do
      expect(GitHubClient).to receive(:get).and_raise(HTTParty::Error)
      expect { subject.repo_array(username) }.to raise_error(ConnectionError)
    end
  end
end
