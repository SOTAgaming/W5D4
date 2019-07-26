require_relative "replies"
require_relative "questions"
require_relative "question_follows"
require_relative "question_likes"
require_relative "questions_database"
require 'byebug'

class User

  def initialize(args)
    #debugger
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
    User.new(user.first)
  end 

  def followed_questions
    QuestionFollows.follower_for_user_id(@id)
  end
    
end 

user = User.new('id' => 1, 'fname' => 'Carlos', 'lname' =>'Garcia')

p user.followed_questions