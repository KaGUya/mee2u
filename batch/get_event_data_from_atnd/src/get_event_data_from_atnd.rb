#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems' unless defined?(gem)
here = File.dirname(__FILE__)
$LOAD_PATH << File.expand_path(File.join(here, 'lib'))

require 'logger'

require 'atnd/event_table_model'
require 'atnd/api_action'
include Atnd

logger = Logger.new(STDOUT)
url = 'http://api.atnd.org/events/'
keyword = '%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0,%E3%82%BD%E3%83%BC%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%89,%E3%83%95%E3%83%AC%E3%83%BC%E3%83%A0%E3%83%AF%E3%83%BC%E3%82%AF,API,ruby,node,java,c++,haskell,scala'

# Entry Point
begin
  logger.info('START  ALL')

  logger.info('START  Get event data from API')
  api = APIAction.new(url, keyword)
  event_data = api.get_event_json(5, 10)
  if event_data['results_returned'] == 0
    logger.warn('Nothing is result')
    exit 0
  end
  logger.info('FINISH Get event data from API')

  logger.info('START  Convert retrieved data')
  model = EventTableModel.new({'hostname' => 'localhost', 'username' => 'mee2u', 'password' => 'kaguya', 'dbname' => 'mee2u'})
  event_data_list = event_data['events']
  event_data_list.map{|x| model.add_data(x['event'])}
  logger.info('FINISH Convert retrieved data')
  
  logger.info('START  Insert retrieved data')
  model.insert
  logger.info('FINISH Insert retrieved data')
  
  logger.info('FINISH ALL')
rescue => ex
  logger.fatal(ex)
end
