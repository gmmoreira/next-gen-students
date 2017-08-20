require 'rails_helper'

RSpec.describe AllStudents do
  describe '#call' do
    subject { described_class.new.call }

    context 'when 0 students' do
      before { Student.destroy_all }

      it                 { is_expected.to be_success }
      its(:value)        { is_expected.to be_an(Enumerable) }
      its(:'value.size') { is_expected.to eq 0 }
    end

    context 'when 1 students' do
      before { FactoryGirl.create_list(:student, 1) }

      it                 { is_expected.to be_success }
      its(:value)        { is_expected.to be_an(Enumerable) }
      its(:'value.size') { is_expected.to eq 1 }
    end

    context 'when 3 students' do
      before { FactoryGirl.create_list(:student, 3) }

      it                 { is_expected.to be_success }
      its(:value)        { is_expected.to be_an(Enumerable) }
      its(:'value.size') { is_expected.to eq 3 }
    end

    context 'when an exception occurs' do
      before { expect(Student).to receive(:all).and_raise }

      it                 { is_expected.to be_failure }
      its(:value)        { is_expected.to be_an(Enumerable) }
      its(:'value.size') { is_expected.to eq 0 }
    end
  end
end
