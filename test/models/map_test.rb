require 'test_helper'

describe Map do
  describe 'create' do
    let(:author){ authors(:ellmo) }
    let(:project){ projects(:dtwid) }

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
    end
  end

  describe 'slug generation' do
    let(:author){ authors(:ellmo) }
    let(:project){ projects(:dtwid) }

    it 'generates slug from name when no url_name is present' do
      map = author.maps.create name: 'A new map', project: project
      map.slug.must_equal 'a-new-map'
    end

    it 'generates slug from url_name' do
      map = author.maps.create name: 'A new map', project: project, url_name: 'Inmost Dens 7'
      map.slug.must_equal 'inmost-dens-7'
    end

    describe 'cuts down spaces and other special chars' do
      it 'example 1' do
        map = author.maps.create name: '  a!  map ', project: project
        map.name.must_equal 'a! map'
        map.url_name.must_equal map.name
        map.slug.must_equal 'a-map'
      end

      it 'example 2' do
        map = author.maps.create name: 'A NEW MAP # 79  ', project: project
        map.name.must_equal 'A NEW MAP # 79'
        map.url_name.must_equal map.name
        map.slug.must_equal 'a-new-map-79'
      end

      it 'example 3' do
        map = author.maps.create name: '--cool   !@#&* map--', project: project
        map.name.must_equal '--cool !@#&* map--'
        map.url_name.must_equal map.name
        map.slug.must_equal 'cool-map'
      end

      it 'example 4' do
        map = author.maps.create name: 'regular name', url_name: ' <> 66asdgu <> ', project: project
        map.name.must_equal 'regular name'
        map.url_name.must_equal '<> 66asdgu <>'
        map.slug.must_equal '66asdgu'
      end
    end
  end
end