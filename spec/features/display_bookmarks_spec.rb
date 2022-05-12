feature 'displays bookmarks' do 
  scenario 'shows the list of bookmarks eg. an url of a bookmarked page' do
    Bookmarks.add('http://www.makersacademy.com/', 'Makers')
    Bookmarks.add('http://www.destroyallsoftware.com/', 'Destroy')
    Bookmarks.add('http://www.google.com/', 'Google')

    visit("/bookmarks")
    expect(page).to have_link('Makers', href: 'http://www.makersacademy.com/') 
    expect(page).to have_link("Destroy", href: 'http://www.destroyallsoftware.com/')
  end 
end