require './lib/bookmarks'

describe Bookmarks do
  describe '#all' do
    it 'able to responds method all' do 
      expect(Bookmarks).to respond_to(:all)
    end 

    it 'returns a list of bookmarks as an array' do 
      Bookmarks.add('http://www.makersacademy.com/', 'Makers')
      Bookmarks.add('http://www.google.com/', 'Google')
      
      bookmarks = Bookmarks.all
      #expect(bookmarks[1]['url']).to eq('http://www.google.com/')
      expect(bookmarks[1]['title']).to eq('Google')
    end
  end 

  describe '#add' do
    it 'responds to two arguments' do
      expect(Bookmarks).to respond_to(:add).with(2).arguments
    end

    it 'adds title and url' do 
      title = "luiza"
      url = "www.luiza.com"
      Bookmarks.add(url, title)
      bookmark = Bookmarks.all.first
      expect(bookmark['title']).to eq(title)
      expect(bookmark['url']).to eq(url)
    end
    
  end
end 


   