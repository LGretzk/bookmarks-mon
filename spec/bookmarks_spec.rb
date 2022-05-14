require './lib/bookmarks'
require 'database_helpers'

describe Bookmarks do
  describe '#all' do
    it 'returns a list of bookmarks as an array' do 
      bookmark = Bookmarks.add('http://www.makersacademy.com/', 'Makers')
      Bookmarks.add('http://www.google.com/', 'Google')

      #persisted_data = PG.connect(dbname: 'bookmark_manager_test').query("SELECT * FROM bookmarks WHERE id=#{bookmark.id};")
      persisted_data = persisted_data('bookmarks', bookmark.id)

      expect(bookmark).to be_a Bookmarks
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Makers'
      expect(bookmark.url).to eq 'http://www.makersacademy.com/'
    end
  end 

  describe '#add' do
    it 'adds title and url' do 
      title = "luiza"
      url = "http://www.luiza.com/"
      bookmark = Bookmarks.add(url, title)
      expect(bookmark.title).to eq(title)
      expect(bookmark.url).to eq(url)
    end

    it 'does not add a new bookmark if the URL is not valid' do
      Bookmarks.add('not a real bookmark', 'not a real bookmark')
      expect(Bookmarks.all).to be_empty
    end
  end

  describe '#delete' do
    it 'deletes the bookmark' do
      bookmark = Bookmarks.add('http://www.makersacademy.com/', 'Makers')
      Bookmarks.delete(bookmark.id)
      expect(Bookmarks.all.length).to eq 0
    end
  end

  describe '#update' do
    it 'updates the bookmark' do
      bookmark = Bookmarks.add('http://www.makersacademy.com/', 'Makers')
      updated_bookmark = Bookmarks.update('http://www.snakersacademy.com', 'Snakers', bookmark.id)

      expect(updated_bookmark).to be_a Bookmarks
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'Snakers'
      expect(updated_bookmark.url).to eq 'http://www.snakersacademy.com'
    end
  end

  describe '#find' do
    it 'returns requested bookmark object' do
      bookmark = Bookmarks.add('http://www.makersacademy.com/', 'Makers')
      result = Bookmarks.find(bookmark.id)

      expect(result).to be_a Bookmarks
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Makers'
      expect(result.url).to eq 'http://www.makersacademy.com/'
    end
  end

  describe '#comments' do
    it 'returns a list of comments of the bookmark' do
      bookmark = Bookmarks.add('http://www.makersacademy.com/', 'Makers')
      DatabaseConnection.query(
        "INSERT INTO comments (id, text, bookmark_id) VALUES(1, 'Learn to code', $1)",
        [bookmark.id]
      )
      comment = bookmark.comments.first
      expect(comment['text']).to eq 'Learn to code'
    end
  end

end
 


   