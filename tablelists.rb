require 'prawn'
require 'yaml'
require 'prawn/measurement_extensions'

Pathname.new('output').children.each { |p| p.unlink }
data = YAML.load_file('data/tablelists.yml')

data.each do |table|
  Prawn::Document.generate("output/#{ table["name"] }.pdf", page_size: 'A4', page_layout: :portrait, margin: [0,0,0,0]) do |pdf|
    pdf.font_families.update("MoonFlower" => {
      normal: 'fonts/Moon Flower.ttf',
      bold: 'fonts/Moon Flower Bold.ttf'
    })
    pdf.font('MoonFlower')
    pdf.stroke_color "000000"

    pdf.text_box table["name"], size: 72, style: :bold, at: [0, 650], align: :center

    table["people"].each_with_index do |person, idx|
      pdf.text_box person, size: 40, style: :normal, at: [0, (-50 * (idx + 1)) + 600], align: :center
    end

  end
end
