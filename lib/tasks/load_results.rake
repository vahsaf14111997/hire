require 'roo'

namespace :load_results do
  desc "Import data from spreadsheet"
  task data: :environment do
    puts 'Importing Data' # add this line
    data = Roo::Spreadsheet.open("lib/spritle_hire_results.xlsx") # open spreadsheet
    headers = data.row(1)

    data.each_with_index do |row, idx|
      next if idx == 0 # skip header row
      result_data = Hash[[headers, row].transpose]
      result_data = result_data.map { |k, v| [k ? (k.class == "String" ? k.strip : k) : k, v ? (v.class == "String" ? v.strip : v) : v] }.to_h
      p result_data,"---"
      Result.create(result_data)
    end
    
    p "***Updated Succefully***"
  end
end
