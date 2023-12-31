# frozen_string_literal: true

require 'caracal'
require 'faraday'
require_relative 'user'
require_relative 'user_service'
require 'json'

def demo_table(file_path)
  header = ['ID', 'Name', 'Avatar', 'Sex', 'Active', 'Created At']
  table_arr = [header]
  service = UserService.new
  service.get_all_users.each { |user| table_arr << user.to_arr }
  Caracal::Document.save(file_path) do |docx|
    # docx.style id: 'special', name: 'Special' do
    #   font 'Time New Roman'
    #   size 26
    #   align :center
    # end
    docx.style id: 'AltFont', name: 'altFont', font: 'Time New Roman'
    docx.h3 'All Users Table'
    docx.table table_arr, border_size: 4, margins: { left: 100, right: 100 }, align: :center do
      cell_style rows[0], size: 26, background: '6495ED', color: 'ffffff', bold: true
      cell_style cols[0], width: 500
      cell_style cols[1], width: 2000
      cell_style cols[2], width: 2500
      cell_style cols[3], width: 1000
      cell_style cols[4], width: 1000
      cell_style cells, size: 26, font: 'Time New Roman'
    end
  end
end



demo_table('table_list.docx')
# write_file("example_document.docx", data)
