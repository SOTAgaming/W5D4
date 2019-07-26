require_relative "replies"
require_relative "user"
require_relative "question_follows"
require_relative "question_likes"
require_relative "questions_database"
require 'byebug'

class Question

  attr_accessor :id, :title, :author_id, :body

  def initialize(args)
    #debugger
    @id = args['id']
    @title= args['title']
    @body = args['body']
    @author_id = args['author_id']
  end 

  def self.all
    questions = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    questions.map { |question| Question.new(question)}
  end 


  def self.find_by_id(id)
   question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT 
        *
      FROM 
        questions 
      WHERE 
        id = ?
    SQL
    Question.new(question.first)
  end 

  def self.find_by_author_id(author_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT 
        *
      FROM 
        questions 
      WHERE 
        author_id = ?
    SQL
    questions.map { |question| Question.new(question)}
  end 
    
end 