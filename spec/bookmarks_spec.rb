require './lib/bookmarks'

describe Bookmarks do
  describe '#all' do
    it 'able to responds method all' do 
      expect(Bookmarks).to respond_to(:all)
    end 

    it 'returns a list of bookmarks as an array' do 
      bookmark = Bookmarks.add('http://www.makersacademy.com/', 'Makers')
      Bookmarks.add('http://www.google.com/', 'Google')
      
      bookmarks = Bookmarks.all
      #expect(bookmarks[1]['url']).to eq('http://www.google.com/')
      #expect(bookmarks[1]['title']).to eq('Google')

      expect(bookmarks.length).to eq 2
      expect(bookmarks.first).to be_a Bookmarks
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com/'

    end
  end 

  describe '#add' do
    it 'responds to two arguments' do
      expect(Bookmarks).to respond_to(:add).with(2).arguments
    end

    it 'adds title and url' do 
      title = "luiza"
      url = "www.luiza.com"
      bookmark = Bookmarks.add(url, title).first
      expect(bookmark['title']).to eq(title)
      expect(bookmark['url']).to eq(url)
    end
    
  end
end 


   