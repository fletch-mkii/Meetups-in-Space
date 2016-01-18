require 'sinatra'
require_relative 'config/application'

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  session[:no_sign_in] = nil
  session[:title] = nil
  session[:date] = nil
  session[:time] = nil
  session[:location] = nil
  session[:description] = nil
  @meetups = Meetup.all.order(:title)
  @users = User.all
  erb :'meetups/index'
end

get '/meetups/new' do
  @title = session[:title]
  @date = session[:date]
  @time = session[:time]
  @location = session[:location]
  @description = session[:description]
  erb :'/meetups/new'
end

get '/meetups/:id' do
  session[:current_meetup_id] = params[:id]
  @meetup = Meetup.find(params[:id])
  @members = @meetup.users.order(:username)
  @meetup.users.each do |user|
    if user[:id] == session[:user_id]
      @not_member = false
    end
  end

  erb :'meetups/show'
end

post '/meetups/join' do
  if session[:user_id].nil?
    flash[:notice] = "Please sign in before trying to join a meetup."
  else
    Membership.create(meetup_id: session[:current_meetup_id], user_id: session[:user_id])
    flash[:notice] = "Meetup successfully joined!"
  end
  redirect '/meetups/' + session[:current_meetup_id]
end

post '/meetups/new' do
  if params[:title].strip.empty? || params[:date].strip.empty? || params[:time].strip.empty? || params[:location].strip.empty? || params[:description].strip.empty?
    session[:title] = params[:title]
    session[:date] = params[:date]
    session[:time] = params[:time]
    session[:location] = params[:location]
    session[:description] = params[:description]
    flash[:notice] = "Please fill out all forms"
    redirect '/meetups/new'
  else
    session[:title] = nil
    session[:date] = nil
    session[:time] = nil
    session[:location] = nil
    session[:description] = nil

    Meetup.create(
    title: params[:title],
    creator: "test",#User.find(session[:user_id])[:username],
    date: params[:date],
    time: params[:time],
    location: params[:location],
    description: params[:description])

    Membership.create(meetup_id: Meetup.last.id, user_id: session[:user_id])

    flash[:notice] = "Meetup successfully created!"
    redirect '/meetups/' + Meetup.last.id.to_s
  end
end

get '/signincheck' do
  if session[:user_id].nil?
    flash[:notice] = "You need to be signed in to do that."
    redirect '/meetups'
  else
    redirect '/meetups/new'
  end
end
