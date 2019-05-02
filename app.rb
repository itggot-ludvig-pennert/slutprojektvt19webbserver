require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'

enable :sessions

db = SQLite3::Database.new("db/database.db")
db.results_as_hash = true

get('/') do
    slim(:index)
end

get('/newuser') do 
    slim(:register)
end

post('/register') do
    hashedpassword = BCrypt::
    begin
        db.execute("INSERT INTO users(username,password) VALUES (?,?)",params["username"],hashedpassword)
    rescue SQLite3::ConstraintException => exception
        session[:usernameerror] = true
        redirect('/newuser')
    end
    session[:username] = params["username"]
    redirect('/welcome')
end


get('/welcome') do
    if session[:username] == nil
        redirect('/denied') 
    end
    slim(:welcome)
end

get('/denied') do
    slim(:denied)
end