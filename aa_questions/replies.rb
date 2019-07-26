require_relative "user"
require_relative "questions"
require_relative "question_follows"
require_relative "question_likes"
require_relative "questions_database"
require 'byebug'

class Reply

  attr_accessor :id, :parent_reply_id, :question_id, :user_id, :body

  def initialize(args)
    #debugger
    @id = args['id']
    @question_id= args['question_id']
    @body = args['body']
    @parent_reply_id = args['parent_reply_id']
    @user_id = args['user_id']
  end 

  def self.all
    replies = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    replies.map { |reply| Question.new(reply)}
  end 


  def self.find_by_id(id)
   reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT 
        *
      FROM 
        replies 
      WHERE 
        id = ?
    SQL
    Reply.new(reply.first)
  end 

  def self.find_by_user_id(user_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT 
        *
      FROM 
        replies
      WHERE 
        user_id = ?
    SQL
    users.map { |user| Reply.new(user)}
  end 
    
  def parent_reply
    p_reply = QuestionsDatabase.instance.execute <<-SQL
    SELECT
      *
    FROM
      replies
    WHERE
      id = #{self.parent_reply_id}

    SQL
    p_reply.map { |reply| Reply.new(reply)}
  end
end 

# rubied = Reply.new({"id" => 1, "question_id" => 1, "parent_reply_id" => 1, "body" => 'still havent figured it out', "user_id" => 2})
# p rubied.parent_reply