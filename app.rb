require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models/management.rb'
require 'date'
enable :sessions

get '/' do
    erb :index
end

get '/signin' do
    erb :sign_in
end

post '/signin' do
    user = User.find_by(mail: params[:mail])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
    end
    redirect '/usermain'
end

get '/signup' do
    erb :sign_up
end

post '/signup' do
    @user = User.create(
        username: params[:username],
        mail: params[:mail],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
    )
    if @user.persisted?
        session[:user] = @user.id
    end
    redirect '/'
end

get '/signout' do
    session[:user] = nil
    redirect '/'
end

get '/usermain' do
    @users = User.all
    @homeworks = Homework.where(user_id: session[:user])
    @records = Record.where(user_id: session[:user])
    @categories = Category.all
    @today = Date.today
    erb :usermain
end

get '/checkrc/:id' do
   @homework = Homework.find(params[:id])
   @records = @homework.records.where(user_id: session[:user]).order('date')
   @sum = @homework.records.sum(:rpage)
   @percentage = 100 * @sum / @homework.page
   erb :checkrc
end

get '/hwregister' do
    @users = User.all
    @categories = Category.all
    erb :hw_register
end

post '/hwregister' do
    @homework = Homework.create(
        category_id: params[:category],
        object: params[:object],
        page: params[:page],
        user_id: session[:user],
        start_day: params[:start_day],
        deadline: params[:deadline]
    )

    redirect '/usermain'
end

get '/howmuch' do
    @users = User.all
    @homeworks = Homework.where(user_id: session[:user])
    erb :how_much
end

post '/howmuch' do
    @record = Record.create(
        #robject: params[:robject],
        rpage: params[:rpage],
        user_id: session[:user],
        date: params[:date],
        homework_id: params[:robject]
    )
    redirect '/usermain'
end

get '/delete/hw/:id' do
    @users = User.all
    Homework.find(params[:id]).destroy
    redirect '/usermain'
end

get '/edit/hw/:id' do
    @users = User.all
    @categories = Category.all
    @homework = Homework.find(params[:id])
    erb:edit_hw
end

post '/renew/hw/:id' do
    @categories = Category.all
    @homework = Homework.find(params[:id])
    @homework.update(
        category_id: params[:category],
        object: params[:object],
        page: params[:page],
        start_day: params[:start_day],
        deadline: params[:deadline]
    )
    redirect '/usermain'
end

get '/delete/rc/:id' do
    Record.find(params[:id]).destroy
    redirect '/usermain'
end


get '/edit/rc/:id' do
    @record = Record.find(params[:id])
    erb:edit_rc
end

post '/renew/rc/:id' do
    @record = Record.find(params[:id])

    @record.rpage = params[:rpage]
    @record.date = params[:date]

    @record.save

    redirect '/usermain'
end

helpers do

    def remain_day(deadline)
        result = Date.new(*deadline.split('-').map(&:to_i)) - Date.today + 1
        return result
    end

    def start_dead(deadline, start_day)
        result = Date.new(*deadline.split('-').map(&:to_i)) - Date.new(*start_day.split('-').map(&:to_i)) + 1
        return result
    end

    def default_should_pace(page, deadline, start_day)
        result = ((page / (Date.new(*deadline.split('-').map(&:to_i)) - Date.new(*start_day.split('-').map(&:to_i)) + 1 ).to_f).to_f.round(2))
        return result
    end

    def yesterday(start_day)
        result = Date.today - Date.new(*start_day.split('-').map(&:to_i))
        return result
    end

    def yesterday_sum_page_homework(homework)
        homework.records.sum(:rpage)
    end

    def error_value(a, b, c)
        result = (a * b - c).to_f.round(3)
        return result
    end

    def remain_page(a, b)
        result = a - b
        return result
    end

    def now_should_pace(a, b)
        result = (a / b).to_f.round(1)
        return result
    end

    def percentage(a,b)
        result = 100 * a / b
        return result
    end
end
