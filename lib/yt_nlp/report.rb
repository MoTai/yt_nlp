require 'prawn'
require 'prawn/table'

module YtNlp
  class Report
    class << self
      def generate_sentiment_report video_id, size, type, data
        stats = cal_stats data
        grouped_data = data.group_by { |r| r[:sentiment] }

        doc = Prawn::Document.new do |pdf|
          pdf.font_families.update("Arial" => {
            normal: font_path("Arial.ttf"),
            italic: font_path("Arial Italic.ttf"),
            bold: font_path("Arial Bold.ttf"),
            bold_italic: font_path("Arial Bold Italic.ttf")
          })

          pdf.font "Arial"

          pdf.text "Sentiment Analysis Reports", size: 25, align: :center

          pdf.text DateTime.now.strftime("%m/%d/%Y %I:%M%p"), align: :center, size: 12

          pdf.move_down 20

          pdf.text "Video ID: <link href='http://youtube.com/watch?v=#{video_id}'><color rgb='#3371b7'><u>#{video_id}</u></color></link>", inline_format: true
          pdf.move_down 5
          pdf.text "Size (processed/input): <b>#{data.length}/#{size}</b>", inline_format: true
          pdf.move_down 5
          pdf.text "Type: <b>#{type}</b>", inline_format: true

          pdf.move_down 10

          pdf.text "Postive: <b>#{stats[:pos]}</b>", inline_format: true
          pdf.text "Negative: <b>#{stats[:neg]}</b>", inline_format: true
          pdf.text "Neutral: <b>#{stats[:neu]}</b>", inline_format: true

          pdf.move_down 5
          pdf.text "Total: <b>#{stats[:total]}</b>", inline_format: true

          pdf.move_down 10

          y = pdf.cursor - 15

          pdf.image(image_path('smiley.jpeg'), width: 75, at: [100, y])
          pdf.draw_text stats[:perc_pos], at: [125, y - 85]
          pdf.image(image_path('sad.jpeg'), width: 75, at: [240, y])
          pdf.draw_text stats[:perc_neg], at: [265, y - 85]
          pdf.image(image_path('neutral.jpeg'), width: 75, at: [380, y])
          pdf.draw_text stats[:perc_neu], at: [405, y - 85]

          pdf.move_down 150

          postives = grouped_data[:positive] || []
          negative = grouped_data[:negative] || []
          neutral = grouped_data[:neutral] || []

          table_data = [['Positive', 'Negative', 'Neutral']].tap do |header|
            rows = postives.zip(negative, neutral).map do |row|
              row.map { |r| r.nil? ? '' : r[:text] }
            end
            header.concat(rows)
          end


          pdf.table(table_data, width: 480)
        end

        doc.render
      end

      def cal_stats data
        neg = data.count { |item| item[:sentiment] == :negative }
        pos = data.count { |item| item[:sentiment] == :positive }
        neu = data.count { |item| item[:sentiment] == :neutral  }
        total = data.length
        return {
          neg: neg,
          neu: neu,
          pos: pos,
          total: data.length,
          perc_neg: "%.2f%" % [neg / total.to_f * 100],
          perc_pos: "%.2f%" % [pos / total.to_f * 100],
          perc_neu: "%.2f%" % [neu / total.to_f * 100]
        }
      end

      def image_path name
        File.expand_path("../images/#{name}", __FILE__)
      end

      def font_path name
        File.expand_path("../fonts/#{name}", __FILE__)
      end
    end

  end
end
