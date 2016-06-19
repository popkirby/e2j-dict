#
# jmdict2pair.rb - convert JMdict to English-Japanese pair
#
# usage:
#   ruby jmdict2pair.rb <JMdict_path> <output_path>
#
# License of this script: Apache License, Version 2.0
# License of the output: Creative Commons Attribution-ShareAlike License, Version 3.0 (see README.md)
#


require 'oga'
require 'json'

if ARGV.size != 2
  STDERR.puts("usage: #{__FILE__} <JMdict_path> <output_path>")
end

jmdict_path = ARGV[0]
output_path = ARGV[1]

class String
  # is the string single word?
  def single_word?
    !self.include?(" ")
  end
end

# conversion method:
# for entry in JMdict/entry:
#   if sense/gloss is one word:
#     add English-Japanese pair of (sense/gloss, r_ele/rev)
#

class JMdictDocument
  attr_reader :entries

  def on_element(ns, name, attrs = [])
    case name
    when 'JMdict'
      @entries = []
    when 'entry'
      @current_rebs = []
      @reb_flag = false
      @gloss_flag = false
    when 'reb'
      @reb_flag = true
    when 'gloss'
      @gloss_flag = true
    end
  end

  def after_element(ns, name)
    @gloss_flag = false
    @reb_flag = false
  end

  def on_text(string)
    if @reb_flag
      # string is yomi(japanese)
      @current_rebs.push(string)
      reb_flag = false
    elsif @gloss_flag
      # string is word(english)
      string = string.strip
      if string.single_word?
        @entries.push({:word => string, :yomi => @current_rebs.dup})
      end

      gloss_flag = false
    end
  end

end

Oga.sax_parse_xml(doc = JMdictDocument.new, File.open(jmdict_path))

# Write to file
File.open(output_path, "w") do |file|
  JSON.dump(doc.entries, file)
end

puts "generation complete (n = #{doc.entries.size})."
