#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems' unless defined?(gem)
here = File.dirname(__FILE__)
$LOAD_PATH << File.expand_path(File.join(here, 'lib'))

require 'net/http'
require 'uri'
require 'json'
require 'logger'

require 'atnd/event_table_model'
require 'atnd/api_action'
include Atnd

logger = Logger.new(STDOUT)
url = 'http://api.atnd.org/events/'
keyword = '%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0,%E3%82%BD%E3%83%BC%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%89,%E3%83%95%E3%83%AC%E3%83%BC%E3%83%A0%E3%83%AF%E3%83%BC%E3%82%AF,web,API,ruby,node,java,c++,haskell,scala'

# Entry Point
begin
  api = APIAction.new(url, keyword)
  puts api.get_event_json(5, 10) 
rescue => ex
  logger.fatal(ex)
end
