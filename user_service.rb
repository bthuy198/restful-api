# frozen_string_literal: true

require 'faraday'
require_relative 'user'
require 'json'
require 'zip'

# user service
class UserService
  @@conn = Faraday.new(url: 'https://6418014ee038c43f38c45529.mockapi.io/api/v1')

  def get_users_active
    res = @@conn.get '/users', { active: true }
    if res.success?
      res.body
      list_users = JSON.parse(res.body)
      users = []
      list_users.each do |user|
        users << User.new(user.transform_keys(&:to_sym))
      end
      users.each { |user| puts user.to_string }
    else
      puts "Error: #{res.message}"
    end
  end

  def get_all_users
    res = @@conn.get '/users'
    if res.success?
      res.body
      list_users = JSON.parse(res.body)
      users = []
      list_users.each do |user|
        users << User.new(user.transform_keys(&:to_sym))
      end
      users.map!(&:to_string)
    else
      puts "Error: #{res.message}"
    end
    users
  end

  def create_user(user)
    req = @@conn.post do |r|
      r.url '/users'
      r.headers['Content-Type'] = 'application/json'
      r.body = user.change_to_json
    end

    if req.success?
      puts req.body
    else
      puts "Error: #{req.message}"
    end
  end

  def update_user(id, edit_info)
    req = @@conn.patch do |r|
      r.url "/users/#{id}"
      r.headers['Content-Type'] = 'application/json'
      r.body = edit_info.to_json
    end

    if req.success?
      puts req.body
    else
      puts "Error: #{req.message}"
    end
  end

  def delete_user(id)
    req = @@conn.delete "/users/#{id}"
    if req.success?
      puts req.body
    else
      puts 'Error'
    end
  end

  def export_doc_file(file_path, data)
  	document = File.new(file_path, "w+")
  	data.each {|user| document.puts user}
  end

  def export_zip_file(folder_path,file_path, data)
  	Zip::File.open(folder_path, Zip::File::CREATE) do |zip|
	zip.add(file_path, file_path)
  	end
  	puts "Completed export doc file and add it to zip file"
  end
end

service = UserService.new
# service.get_all_users
# service.get_users_active

User.new({ created_at: Time.now,
           name: 'Dang Thi Bich Thuy',
           avatar: 'https://duhocvietglobal.com/wp-content/uploads/2018/12/dat-nuoc-va-con-nguoi-anh-quoc.jpg',
           sex: 'female',
           active: true })

# service.create_user(user)

# service.update_user(75, edit_info)
# service.delete_user(67)

data = service.get_all_users

service.export_doc_file("users-list.docx", data)
service.export_zip_file('users.zip', "users-list.docx", data)
