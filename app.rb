require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'
require_relative 'module.rb'

include MyModule
enable :sessions

db = SQLite3::Database.new("db/dates.db")
db.results_as_hash = true

get('/') do
    slim(:index)
end

get('/newuser') do 
    slim(:register)
end

post('/register') do
    register(params['username'],params['password'])
end

post('/login') do
    login(params['username'],params['password'])
    if session[:usernameerror] == true
        redirect('/newuser')
    elsif
        session[:username] == true
        redirect('/welcome')
    end

end

get('/welcome') do
    
    slim(:welcome)
end

get('/denied') do
    slim(:denied)
end