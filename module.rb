require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'

module MyModule
    
    def connect()
        db = SQLite3::Database.new("db/dates.db")
        db.results_as_hash = true
        return db
    end

    def check_session
        if session[:username] == nil
            redirect('/denied') 
        end
    end
    
    def login(username,password)
        db = connect()
        db_pw = db.execute("SELECT password FROM users WHERE username =?",username)
        if BCrypt::Password.new(db_pw[0]['password']) == password
        #JÄMFÖR BCRYPT PASSWORD MED sdöfjkl
            session[:username] = username

        end

    end

    def register(username,password)

        db = connect()
        password = BCrypt::Password.create(password)
        
        if username_exist?(username) == true
            db.execute("INSERT INTO users(username,password) VALUES (?,?)",username,password)
            session[:username] = username
        else
            return session[:usernameerror] == true
        end

    end

    def username_exist?(un)
        db = connect()
        name = db.execute("SELECT username FROM users WHERE username =?",un)
        if name == []
            return true
        else
            return false
        end
    end
end