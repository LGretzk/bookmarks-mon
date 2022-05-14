feature "add bookmark" do
  scenario "adds a bookmark to the list" do 
    visit("/bookmarks")
    click_link("Add bookmark")
    fill_in :new_url, with: "http://www.luiza.com"
    fill_in :title, with: 'Luiza'
    click_button("Submit")
    expect(page).to have_link("Luiza", href: 'http://www.luiza.com')
  end

  scenario "checks if the bookmark is valid" do
    visit("/bookmarks/add")
    fill_in :new_url, with: 'not a real bookmark'
    fill_in :title, with: 'Google'
    click_button("Submit")
    expect(page).to have_content "You must submit a valid URL."
    expect(page).not_to have_content 'not a real bookmark'
  end
end
