require './lib/bookmarks'
require 'database_helpers'

describe Bookmarks do
  describe '#all' do
    it 'returns a list of bookmarks as an array' do 
      bookmark = Bookmarks.add('http://www.makersacademy.com/', 'Makers')
      p bookmark
      Bookmarks.add('http://www.google.com/', 'Google')
      
      # Change the test, so instead of relying on Bookmarks.all we use 
      # the bookmark object.
      # Instead of: bookmarks = Bookmarks.all

      #persisted_data = PG.connect(dbname: 'bookmark_manager_test').query("SELECT * FROM bookmarks WHERE id=#{bookmark.id};")
      persisted_data = persisted_data(bookmark.id)
      expect(bookmark).to be_a Bookmarks
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Makers'
      expect(bookmark.url).to eq 'http://www.makersacademy.com/'
    end
  end 

  describe '#add' do
    it 'adds title and url' do 
      title = "luiza"
      url = "www.luiza.com"
      bookmark = Bookmarks.add(url, title)
      expect(bookmark.title).to eq(title)
      expect(bookmark.url).to eq(url)
    end
    
  end
end 


   