
feature 'adding and viewing comments' do
  scenario 'a comment is added to a bookmark' do
    bookmark = Bookmarks.add('http://www.makersacademy.com', 'Makers')
    visit('/bookmarks')
    first('.bookmark').click_button 'Add Comment'

    expect(current_path).to eq "/bookmarks/#{bookmark.id}/comments/new"
    fill_in('comment', with: 'Learn how to code')
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(first('.bookmark')).to have_content'Learn how to code'
  end
end