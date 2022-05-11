feature "add bookmark" do
  scenario "adds a bookmark to the list" do 
    connection = PG.connect(dbname: 'bookmark_manager_test')
    visit("/bookmarks")
    click_link("Add bookmark")
    fill_in :new_url, with: "http://www.luiza.com"
    fill_in :title, with: 'Luiza'
    click_button("Submit")
    expect(page).to have_content "Luiza"
  end
end