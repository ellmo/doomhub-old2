require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

  describe 'unsigned user' do
    describe 'POST create' do
      let(:params){{
        name: 'asd'
      }}

      before { sign_in }

      it 'must not authorize' do
        post :create, project: params
        response.status.must_equal 401
      end
    end
  end

  describe 'registered user' do
    describe 'POST create' do
      let(:params){{
        name: 'asd'
      }}
      let(:user){ users :ellmo }
      let(:project){ assigns :project }

      before do
        sign_in user
        post :create, project: params
      end

      it 'must authorize and succeed' do
        response.status.must_equal 200
      end

      it 'must create a project' do
        project.id.nil?.must_equal false
      end

      it 'must assign current_user to the project' do
        project.user.must_equal user
      end
    end
  end

end
