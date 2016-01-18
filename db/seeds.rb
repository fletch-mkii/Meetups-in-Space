# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.create(username: 'testuser1', uid: 1, provider: "what?", email: "testemail1@emailtest.com", avatar_url: "http://i.imgur.com/TRYH1")
User.create(username: 'testuser2', uid: 2, provider: "facebook", email: "testemail2@emailtest.com", avatar_url: "http://i.imgur.com/TRYH2")
User.create(username: 'testuser3', uid: 3, provider: "anything", email: "testemail3@emailtest.com", avatar_url: "http://i.imgur.com/TRYH2")

Meetup.create(title: "make boats", creator: "boatman", date: "01/03/15", time: "1:11", location: "THE RIVER", description: "RIDE BOATS WHATCHU THINK WE DOIN'?")
Meetup.create(title: "make hats", creator: "hatman", date: "02/03/15", time: "2:22", location: "THE HAT STORE", description: "MAKE HATS N SHIT YO")
Meetup.create(title: "make shoess", creator: "shoeman", date: "03/03/15", time: "3:33", location: "THE SHOEBOX", description: "We gonna make shoes kid.")

Membership.create(meetup_id: 1, user_id: 1)
Membership.create(meetup_id: 2, user_id: 1)
Membership.create(meetup_id: 2, user_id: 2)
