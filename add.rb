require 'docx'
require 'zip'

# Tạo tài liệu mới
doc = Docx::Document.new('template.docx')

# Thêm đoạn văn vào tài liệu
doc.paragraphs << 'Xin chào, đây là một tài liệu Word đơn giản được tạo bằng gem docx.'
doc.paragraphs << 'Bạn có thể thêm đoạn văn, bảng và nội dung khác bằng gem này.'

# Lưu tài liệu dưới dạng tệp .docx
output_path = 'output_document.docx'
doc.save(output_path)
doc.close

# Tạo tệp ZIP và thêm tài liệu Word vào đó
zip_path = 'output_document.zip'
Zip::File.open(zip_path, Zip::File::CREATE) do |zip|
zip.add(output_path, output_path)
end