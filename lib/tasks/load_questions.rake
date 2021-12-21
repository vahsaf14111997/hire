require 'roo'

namespace :load_questions do
  desc "Import data from spreadsheet"
  task data: :environment do
    puts 'Importing Data' # add this line
    data = Roo::Spreadsheet.open("lib/spritle_hire_questions.xlsx") # open spreadsheet
    headers = data.row(1)

    data.each_with_index do |row, idx|
      next if idx == 0 # skip header row
      question_data = Hash[[headers, row].transpose]
      question_data = question_data.map { |k, v| [k ? (k.class == "String" ? k.strip : k) : k, v ? (v.class == "String" ? v.strip : v) : v] }.to_h
      p question_data,"---"
      Question.create(question_data)
    end
    
    p "***Updated Succefully***"
  end
end
