require 'rails_helper'

RSpec.describe 'students/_student' do
  let(:student) { create(:student) }

  before do
    render 'students/student', student: student
  end

  it { expect(rendered).to match student.first_name }
  it { expect(rendered).to match student.last_name }
  it { expect(rendered).to match student_path(id: student.id) }
end
