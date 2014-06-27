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

    describe 'name / url_name validation' do
      it 'NOT valid with non-unique name and default url_name' do
        project = user.projects.build name: 'Doom The Way id Did'
        project.valid?.must_equal false
      end

      it 'NOT valid with non-unique name and unique custom url_name' do
        project = user.projects.build name: 'Doom The Way id Did', url_name: 'A new project'
        project.valid?.must_equal false
      end

      it 'NOT valid with unique name and non-unique custom url_name' do
        project = user.projects.build name: 'A new project', url_name: 'Doom The Way id Did'
        project.valid?.must_equal false
      end
    end
  end

  describe 'slug generation' do
    let(:user){users(:ellmo)}

    it 'generates slug from name when no url_name is present' do
      project = user.projects.build name: 'A new project'
      project.save.must_equal true
      project.url_name.must_equal project.name
      project.slug.must_equal 'a-new-project'
    end

    it 'generates slug from url_name' do
      project = user.projects.build name: 'A new project', url_name: 'Some other name'
      project.save.must_equal true
      project.url_name.must_equal 'Some other name'
      project.slug.must_equal 'some-other-name'
    end

    describe 'cuts down spaces and other special chars' do
      it 'example 1' do
        project = user.projects.build name: '  a!  project '
        project.save.must_equal true
        project.name.must_equal 'a! project'
        project.url_name.must_equal project.name
        project.slug.must_equal 'a-project'
      end

      it 'example 2' do
        project = user.projects.build name: 'A NEW PROJECT # 34  '
        project.save.must_equal true
        project.name.must_equal 'A NEW PROJECT # 34'
        project.url_name.must_equal project.name
        project.slug.must_equal 'a-new-project-34'
      end

      it 'example 3' do
        project = user.projects.build name: '--cool   !@#&* project--'
        project.save.must_equal true
        project.name.must_equal '--cool !@#&* project--'
        project.url_name.must_equal project.name
        project.slug.must_equal 'cool-project'
      end

      it 'example 4' do
        project = user.projects.build name: 'regular name', url_name: ' <> 66asdgu <> '
        project.save.must_equal true
        project.name.must_equal 'regular name'
        project.url_name.must_equal '<> 66asdgu <>'
        project.slug.must_equal '66asdgu'
      end
    end
  end

  describe 'friendly_id finds' do
    it 'can be found with slug' do
      Project.friendly.find('doom-the-way-id-did').must_equal projects(:dtwid)
    end
  end
end
