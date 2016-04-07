require 'rails_helper'

RSpec.describe LanguageCheckAttempt, type: :model do
  describe '#new' do
    it 'errors out if invalid args' do
      invalid_args = [{ successful: true, favourite_language: nil },
                      { successful: true },
                      { successful: false, error: nil },
                      { successful: false }
                     ]

      invalid_args.each do |invalid|
        expect { LanguageCheckAttempt.new invalid }
          .to raise_error ArgumentError
      end
    end
  end

  context '(when successful)' do
    let(:language) { 'Ruby' }

    subject do
      LanguageCheckAttempt.new successful: true, favourite_language: language
    end

    describe '#if_successful' do
      it do
        expect { |b| subject.if_successful(&b) }
          .to yield_with_args language
      end
    end

    describe '#if_failed' do
      it { expect { |b| subject.if_failed(&b) }.not_to yield_with_args }
    end
  end

  context '(when failed)' do
    let(:language) { 'Ruby' }
    let(:error) { StatusError.new }

    subject do
      LanguageCheckAttempt.new successful: false, error: error
    end

    describe '#if_successful' do
      it { expect { |b| subject.if_successful(&b) }.not_to yield_with_args }
    end

    describe '#if_failed' do
      context '(when error is UserFriendly)' do
        it 'uses the UserFriendly message string' do
          expect { |b| subject.if_failed(&b) }
            .to yield_with_args error.message
        end
      end

      context '(when error is not UserFriendly)' do
        let(:error) { ArgumentError.new }
        it 'uses its own user-friendly message string' do
          expect { |b| subject.if_failed(&b) }
            .to yield_with_args 'something went unexpectedly wrong'
        end
      end
    end
  end
end
