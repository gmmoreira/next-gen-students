require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:setup_stubs) {}

  before do
    setup_stubs
    @controller = described_class.new
  end

  subject do
    response
  end

  describe 'GET #index' do
    before do
      get :index
    end

    context 'when everything is ok' do
      let(:setup_stubs) do
        AppContainer.stub('all_students', Proc.new { Right(create_list(:student, 3)) })
      end

      it { expect(flash.key?(:alert)).to eq false }
    end

    context 'when an error occurs fetching students' do
      let(:setup_stubs) do
        AppContainer.stub('all_students', Proc.new { Left([]) })
      end

      it { expect(flash.key?(:alert)).to eq true }
    end
  end

  describe 'GET #show' do
    let(:student) { create(:student) }

    before do
      get :show, params: { id: student.id }
    end

    context 'when everything is ok' do
      let(:setup_stubs) do
        AppContainer.stub('find_student', Proc.new { Right(student) })
      end

      its(:status) { is_expected.to eq 200 }
    end

    context 'when error occurs fetching student' do
      let(:setup_stubs) do
        AppContainer.stub('find_student', Proc.new { Left(student) })
      end

      it           { is_expected.to redirect_to(students_url) }
      its(:status) { is_expected.to eq 302                    }
      it           { expect(flash.key? :error).to eq true     }
    end
  end

  describe "POST #create" do
    before do
      post :create, params: params
    end

    context 'when everything is ok' do
      let(:student) { create(:student) }
      let(:params) do
        { student: student.attributes }
      end
      let(:setup_stubs) do
        AppContainer.stub('create_student',  Proc.new { Right(student) })
        AppContainer.stub('welcome_student', Proc.new { Right(student) })
      end

      its(:status) { is_expected.to eq 302 }
      it           { is_expected.to redirect_to(student_url(id: student.id)) }
      it           { expect(flash.key?(:notice)).to eq true }
    end

    context 'when fails to create student' do
      let(:student) { build(:student) }
      let(:params) do
        { student: student.attributes }
      end
      let(:setup_stubs) do
        AppContainer.stub('create_student', Proc.new { Left(student) } )
      end

      its(:status) { is_expected.to eq 409 }
      it           { expect(flash.key?(:error)).to eq true }
    end

    context 'when fails to send email' do
      let(:student) { create(:student) }
      let(:params) do
        { student: student.attributes }
      end
      let(:setup_stubs) do
        AppContainer.stub('create_student',  Proc.new { Right(student) })
        AppContainer.stub('welcome_student', Proc.new { Left(student) })
      end

      its(:status) { is_expected.to eq 302 }
      it           { is_expected.to redirect_to(student_url(id: student.id)) }
      it           { expect(flash.key?(:alert)).to eq true }
    end
  end
end
