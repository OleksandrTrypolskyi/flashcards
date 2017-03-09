# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = [
  "http://www.languagedaily.com/learn-german/vocabulary/common-german-words",
  "http://www.languagedaily.com/learn-german/vocabulary/most-common-german-words-2",
  "http://www.languagedaily.com/learn-german/vocabulary/common-german-words-3",
  "http://www.languagedaily.com/learn-german/vocabulary/common-german-words-4",
  "http://www.languagedaily.com/learn-german/vocabulary/common-german-words-5",
  "http://www.languagedaily.com/learn-german/vocabulary/common-german-words-6",
  "http://www.languagedaily.com/learn-german/vocabulary/common-german-words-7",
  "http://www.languagedaily.com/learn-german/vocabulary/common-german-words-8",
  "http://www.languagedaily.com/learn-german/vocabulary/common-german-words-9",
  "http://www.languagedaily.com/learn-german/vocabulary/common-german-words-10",
  "http://www.languagedaily.com/learn-german/vocabulary/common-german-words-11",
  "http://www.languagedaily.com/learn-german/vocabulary/common-german-words-12"]


  PAGE_URL.each do |url|
    @page = Nokogiri::HTML(open(url))
      # English words
      original_words = @page.css('div.jsn-article-content tbody td.bigLetter+td')
      original_words_length = @page.css('div.jsn-article-content tbody td.bigLetter+td').length
      # German words
      translated_words = @page.css('div.jsn-article-content tbody td.bigLetter')
      # Take each German word and add it to array if it has translation.
      original_number = 0
      translated_words.each do |translated|
        original = original_words[original_number].text.to_s
        if !original.blank? && original_number <= original_words_length
          Card.create!(original_text: original, translated_text: translated.text.to_s)
        end
        original_number = original_number + 1
    end
  end
