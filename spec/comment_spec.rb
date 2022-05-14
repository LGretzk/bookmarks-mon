require 'database_helpers'

require 'comment'
require 'bookmarks'

describe Comment do
  describe '.create' do
    it 'creates a new comment' do
      bookmark = Bookmarks.add('http://www.makersacademy.com/', 'Makers')
      comment = Comment.create('Learn to code', bookmark.id)

      persisted_data = persisted_data('comments', comment.id)

      expect(comment).to be_a Comment
      expect(comment.id).to eq persisted_data.first['id']
      expect(comment.text).to eq 'Learn to code'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end
end