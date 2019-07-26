require_relative "replies"
require_relative "user"
require_relative "questions"
require_relative "question_likes"
require_relative "questions_database"
require 'byebug'

class QuestionFollows

  attr_accessor :id, :question_id, :follower_id

  def initialize(args)
    #debugger
    @id = args['id']
    @question_id= args['question_id']
    @follower_id = args['follower']
  end 

  def self.all
    questions = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
    questions.map { |question| Question.new(question)}
  end 


  def self.find_by_id(id)
   question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT 
        *
      FROM 
        question_follows
      WHERE 
        id = ?
    SQL
    QuestionFollows.new(question.first)
  end 

  def self.follower_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT 
      users.id, users.fname, users.lname
    FROM 
      users
    JOIN
      question_follows
    ON
      question_follows.follower_id = users.id 
    WHERE
      question_follows.question_id = ?;
    SQL
    #debugger
    users.map { |user| User.new(user)}
end 

def self.follower_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT 
      questions.id, questions.title, questions.body, questions.author_id
    FROM 
      questions
    JOIN
      question_follows
    ON
      question_follows.follower_id = questions.id 
    WHERE
      question_follows.follower_id = ?;
    SQL
    questions.map { |question| Question.new(question)}
end 
end 

# # p User.all
#  p QuestionFollows.follower_for_question_id(1)
# # p QuestionFollows.follower_for_user_id(2)