class Faq < ActiveRecord::Base
  unloadable
  acts_as_searchable :columns => ['question','answer']
  validates_presence_of :creator
  validates_presence_of :question
  validates_presence_of :answer, :message => "Missing answer..."
  # Returns a short description of the projects (first lines)
  def short_question(length = 50)
    if (!question.nil?)
      if (question.length > length)
        return (question[0,length].strip << "\.\.\.")
      else
        return question
      end
    end
  end

  # Returns a short description of the projects (first lines)
  def short_answer(length = 50)
    if (!answer.nil?)
      if (answer.length > length)
        return (answer[0,length].strip << "\.\.\.")
      else
        return answer
      end
    end
  end
end
