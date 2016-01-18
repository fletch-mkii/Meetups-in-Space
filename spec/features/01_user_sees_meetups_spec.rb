require 'spec_helper'

# system "rake db:migrate"

feature "user sees list of meetups" do
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

  scenario "index displays all meetups" do
    visit '/'

    expect(page).to have_content "make shoes"
  end

  scenario "meetups are in alphabetical order" do
    visit '/'

    expect(page).to have_content "Meetups in Space Sign In Meetups make hats"
  end
end
