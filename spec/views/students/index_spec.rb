require 'rails_helper'

RSpec.describe 'students/index' do
  let(:students) { create_list(:student, 3) }

  before do
    assign(:students, students)
    render
  end

  subject { rendered }

  describe 'display a list of students' do
    it { is_expected.to match /<div class="ui divided list">/ }
    it { is_expected.to match students.first.first_name       }
    it { is_expected.to match students.last.first_name        }
  end
end
