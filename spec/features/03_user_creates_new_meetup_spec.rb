require 'spec_helper'

feature "user submits new meetup" do
  before(:each) do
    Meetup.create(title: "make shoes",
      creator: "shoeman",
      date: "03/03/15",
      time: "3:33",
      location: "THE SHOEBOX",
      description: "We gonna make shoes kid.")
    Meetup.create(title: "make hats",
      creator: "hatman",
      date: "02/03/15",
      time: "2:22",
      location: "THE HAT STORE",
      description: "We gonna make hats kid.")
  end

  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario "user must be logged in to create a new meetup" do
    visit "/meetups"
    click_link 'Create New Meetup'

    # expect(page).to have_content "You need to be signed in to do that."
    expect(page).to have_content "Meetups make hats"
  end

  scenario "index page has a link to the /meetups/new page" do
    visit "/meetups"
    sign_in_as(user)
    click_link 'Create New Meetup'

    expect(page).to have_content "Create New Meetup"
    page.should have_xpath("//input")
  end

  context "user has filled out the New Meetups form" do
    before(:each) do
      visit "/meetups/new"
      fill_in "title", with: "placeholder title"
      fill_in "date", with: "11/11/11"
      fill_in "time", with: "11:11"
      fill_in "location", with: "placeholder location"
      fill_in "description", with: "placeholder description"
      click_button 'Create'
    end

    scenario "create new meetup page should add the meetup to the index after creation" do
      visit "/meetups"

      expect(page).to have_content "placeholder title"
    end

    scenario "expect newly created meetup to have a details page" do
      visit "/meetups"
      click_link "placeholder title"

      expect(page).to have_content "placeholder location"
    end
  end

  scenario "expect form not to be submitted if incomplete" do
    visit "/meetups/new"
    fill_in "title", with: "oopsie"
    click_button 'Create'

    expect(page).to have_content "Create New Meetup"
    page.should have_xpath("//input")
  end
end
