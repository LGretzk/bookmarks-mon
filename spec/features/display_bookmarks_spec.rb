feature 'displays bookmarks' do 
  scenario 'shows the list of bookmarks eg. an url of a bookmarked page' do
    Bookmarks.add('http://www.makersacademy.com/', 'Makers')
    Bookmarks.add('http://www.destroyallsoftware.com/', 'Destroy')
    Bookmarks.add('http://www.google.com/', 'Google')

    visit("/bookmarks")
    expect(page).to have_content "Makers"
    expect(page).to have_content "Destroy"
  end 
end