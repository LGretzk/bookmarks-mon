feature 'Deleting a bookmark' do
  scenario 'A user can delete a bookmark' do
    Bookmarks.add('http://makersacademy.com', 'Makers')
    visit('/bookmarks')
    expect(page).to have_link('Makers', href: 'http://makersacademy.com')

    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers', href: 'http://makersacademy.com')
  end
end