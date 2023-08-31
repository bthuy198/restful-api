require 'caracal'

def write_file
  Caracal::Document.save 'example.docx' do |docx|
  # page 1
  docx.h1 'Page 1 Header'
  docx.hr
  docx.p
  docx.h2 'Section 1'
  docx.p  'Lorem ipsum dolor....'
  docx.p

  # page 2
  docx.page
  docx.h1 'Page 2 Header'
  docx.hr
  docx.p
  docx.h2 'Section 2'
  docx.p  'Lorem ipsum dolor....'
  docx.ul do
    li 'Item 1'
    li 'Item 2'
  end
  docx.p
  # docx.img 'https://www.example.com/logo.png', width: 500, height: 300
end
end

write_file
