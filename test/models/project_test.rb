require "test_helper"

describe Project do
  describe 'create' do
    let(:user){users(:ellmo)}

    it 'valid with unique name and default url_name' do
      project = user.projects.build name: 'A new project'
      project.valid?.must_equal true
    end

    it 'valid with unique name and a custom url_name' do
      project = user.projects.build name: 'A new project', url_name: 'some-other-name'
      project.valid?.must_equal true
    end
  end

  describe 'slug generation' do
    let(:user){users(:ellmo)}

    it 'valid with unique name and default url_name' do
      project = user.projects.build name: 'A new project'
      project.save.must_equal true
      project.slug.must_equal 'a-new-project'
    end

    it 'valid with unique name and a custom url_name' do
      project = user.projects.build name: 'A new project', url_name: 'Some other name'
      project.save.must_equal true
      project.slug.must_equal 'some-other-name'
    end
  end

  describe 'friendly_id finds' do
    it 'can be found with slug' do
      Project.friendly.find('doom-the-way-id-did').must_equal projects(:dtwid)
    end
  end
end
