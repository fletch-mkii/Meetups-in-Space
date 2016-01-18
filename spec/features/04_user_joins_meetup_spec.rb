require 'spec_helper'

feature "user sees meetup details" do
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

    Membership.create(meetup_id: 7, user_id: 1)
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

  scenario "meetup is not joined when user is logged out, and a failure message is displayed" do
    visit "/meetups"
    click_link 'make shoes'
    click_button "Join Meetup"

    expect(page).to_not have_content "jarlax1"
    expect(page).to have_content "Please sign in before trying to join a meetup."
  end

  scenario "meetup is joined when user is logged in, and a success message is displayed" do
    sign_in_as(user)
    visit "/meetups"
    click_link 'make shoes'
    click_button "Join Meetup"

    expect(page).to have_content "jarlax1"
    expect(page).to have_content "Meetup successfully joined!"
  end
end
