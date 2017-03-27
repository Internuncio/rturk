module RTurk

  class AnswerParser

    require 'cgi'

    def self.parse(xml)
      answer_xml = Nokogiri::XML(CGI.unescapeHTML(xml.to_s))
      answer_hash = {}
      answers = answer_xml.xpath('//xmlns:Answer')
      answers.each do |answer|
        key, value = nil, nil
        answer.children.each do |child|
          next if child.blank?
          if child.name == 'QuestionIdentifier'
            key = child.inner_text
          else
            value = child.inner_text
          end

          next if value.nil?

          if answer_hash.has_key?(key)
            old_hash_value = answer_hash[key]
            new_array = []
            new_array.push(old_hash_value)
            new_array.push(value)
            answer_hash[key] = new_array.flatten
          else
            answer_hash[key] = value
          end
        end
      end
      answer_hash
    end


  end

end
