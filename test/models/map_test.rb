require 'test_helper'

describe Map do
  describe 'create' do
    let(:user){users(:ellmo)}
    let(:author){user.author}
    let(:project){projects(:dtwid)}

    it 'valid with unique name and default url_name and lump' do
      map = author.maps.build name: 'A new map', project: project
      map.valid?.must_equal true
    end

    it 'valid with unique name and a custom url_name' do
      map = author.maps.build name: 'A new map', project: project, url_name: 'A custom name'
      map.valid?.must_equal true
    end

    it 'valid with unique name and a custom lump' do
      map = author.maps.build name: 'A new map', project: project, lump: 'SUPERMAP'
      map.valid?.must_equal true
    end

    it 'valid with unique name and a custom url_name and lump' do
      map = author.maps.build name: 'A new map', project: project, lump: 'SUPERMAP', url_name: 'A custom name'
      map.valid?.must_equal true
    end

    describe 'name / url_name validation' do
      describe 'within the same project' do
        it 'NOT valid with non-unique name and default url_name' do
          map = author.maps.build name: 'Engineering Bay', project: project
          map.valid?.must_equal false
        end

        it 'NOT valid with non-unique name and unique custom url_name' do
          map = author.maps.build name: 'Engineering Bay', project: project, url_name: 'Abyssal Stronghold'
          map.valid?.must_equal false
        end

        it 'NOT valid with unique name and non-unique custom url_name' do
          map = author.maps.build name: 'Abyssal Stronghold', project: project, url_name: 'Engineering Bay'
          map.valid?.must_equal false
        end
      end

      describe 'different projects' do
        let(:project) { projects(:brutal_doom) }
        it 'valid with non-unique name and default url_name' do
          map = author.maps.build name: 'Engineering Bay', project: project
          map.valid?.must_equal true
        end
      end



      # it 'NOT valid with non-unique name and unique custom url_name' do
      #   project = user.projects.build name: 'Doom The Way id Did', url_name: 'A new project'
      #   project.valid?.must_equal false
      # end

      # it 'NOT valid with unique name and non-unique custom url_name' do
      #   project = user.projects.build name: 'A new project', url_name: 'Doom The Way id Did'
      #   project.valid?.must_equal false
      # end
    end
  end
end