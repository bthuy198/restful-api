# frozen_string_literal: true

require 'csv'
require_relative 'user'
require_relative 'user_service'

def export_to_csv(file_path)
  header = ['ID', 'Name', 'Avatar', 'Sex', 'Active', 'Created At']
  table_arr = [header]
  service = UserService.new
  service.get_all_users.each do |user|
    p user.to_arr
    table_arr << user.to_arr
  end
  File.write(file_path, table_arr.map(&:to_csv).join)
end

def read_file(file_path)
  service = UserService.new
  begin
    source = File.read(file_path)
    CSV.parse(source, headers: true) do |row|
      user = User.new({
                        name: row['Name'],
                        avatar: row['Avatar'],
                        sex: row['Sex'],
                        active: row['Active'] == 'TRUE',
                        created_at: row['Created At']
                      })
      service.create_user(user)
    end
  rescue StandardError
    puts "Failed to read file #{file_path}"
  end
end

# export_to_csv("users.csv")
read_file('users.csv')
