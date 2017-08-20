require 'rails_helper'

RSpec.describe 'students/form' do
  let(:student) { build(:student) }

  before do
    assign(:student, student)
    render 'students/form'
  end

  subject { rendered }

  describe 'render a input for first name ' do
    it { is_expected.to match /name="student\[first_name\]"/ }
    it { is_expected.to match /name="student\[last_name\]"/ }
    it { is_expected.to match /name="student\[email\]"/ }
  end
end
