require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)

require 'app/scrapper.rb'

#scrap = Scrapper.new.save_json

#scrapsv = Scrapper.new.save_csv

