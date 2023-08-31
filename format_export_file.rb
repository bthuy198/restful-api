# frozen_string_literal: true

require 'htmltoword'
require 'faraday'
require_relative 'user'
require_relative 'user_service'
require 'json'
require 'zip'

# class for export file
class ExportFile
  def format_and_export(file_path, data)
    first_html = '<html lang="en">
                  <head>
                  </head>
                  <body>
                      <table>
                          <tr>
                              <th>ID</th>
                              <th>Created At</th>
                              <th>Name</th>
                              <th>Avatar</th>
                              <th>Sex</th>
                              <th>Active</th>
                          </tr>'

    html_data = data.collect do |user|
      "<tr>
            <td>#{user.id}</td>
            <td>#{user.created_at}</td>
            <td>#{user.name}</td>
            <td>#{user.avatar}</td>
            <td>#{user.sex}</td>
            <td>#{user.active}</td>
        </tr>"
    end.join

    end_html = '</table></body></html>'
    html_str = first_html + html_data + end_html

    Htmltoword::Document.create_and_save html_str, file_path
  end

  def export_zip_file(folder_path, file_path, _data)
    Zip::File.open(folder_path, Zip::File::CREATE) do |zip|
      zip.add(file_path, file_path)
    end
    puts 'Completed export doc file and add it to zip file'
  end
end

service = UserService.new
data = service.get_all_users

export = ExportFile.new
# export file
export.format_and_export('users-list.docx', data)
export.export_zip_file('users.zip', 'users-list.docx', data)
