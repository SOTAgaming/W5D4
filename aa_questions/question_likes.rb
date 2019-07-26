require_relative "replies"
require_relative "user"
require_relative "questions"
require_relative "question_follows"
require_relative "questions_database"
require 'byebug'


class QuestionLikes

  attr_accessor :id, :author_id, :question_id

  def initialize(args)
    #debugger
    @id = args['id']
    @author_id= args['author_id']
    @question_id = args['question']
  end 

  def self.all
    likes = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    likes.map { |like| Question.new(like)}
  end 


  def self.find_by_id(id)
   like = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT 
        *
      FROM 
        question_likes
      WHERE 
        id = ?
    SQL
    QuestionLikes.new(like.first)
  end 
    
end 