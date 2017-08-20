require 'rails_helper'

RSpec.describe 'students/new' do
  let(:student) { Student.new }

  before do
    assign(:student, student)
    render
  end

  subject { rendered }

  describe 'it renders a form' do
    it { is_expected.to match /form/ }
  end
end
