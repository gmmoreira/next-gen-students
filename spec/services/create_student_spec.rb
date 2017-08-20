require 'rails_helper'

RSpec.describe CreateStudent do

  describe '#call' do
    subject { described_class.new.call(params) }

    context 'valid params' do
      let(:params) { FactoryGirl.attributes_for(:student) }

      it { is_expected.to be_success }
      it { expect(subject.value).to be_kind_of Student }
    end

    context 'invalid params' do
      let(:params) { FactoryGirl.attributes_for(:student, first_name: nil) }

      it { is_expected.to be_failure }
      it { expect(subject.value).to be_kind_of Student }
    end
  end
end
