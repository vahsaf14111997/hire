module Admin::QuestionHelper
  def trim_text(text_string)
    if text_string.length > 50
      text_string.match(/^.{0,20}\b/)[0] + "..."
    else
      text_string
    end
  end
end
