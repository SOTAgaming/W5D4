require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton
  def initialize
    super('questions.db')
    self.type_translation = true 
    self.results_as_hash = true 
  end 
end 

class User

  def initialize(args)
    @id = args['id']
    @fname = args['fname']
    @lname = args['lname']
  end 

  def self.all
    users = QuestionsDatabase.instance.execute("SELECT * FROM users")
    users.map { |user| User.new(user)}
  end 


  def self.find_by_id(id)
   user = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT 
        *
      FROM 
        users 
      WHERE 
        id = ?
    SQL
    User.new(user)
  end 
    
end 

class Questions

end

class Replies 

end 

class QuestionFollows

end 

class QuestionLikes

end 
