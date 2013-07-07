#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Monetizer::Application.load_tasks

namespace :db do
  desc "full database rebuild"
  task :rebuild do
    puts 'start db:migrate:reset'
    Rake::Task['db:migrate:reset'].invoke
    puts 'finished db:migrate:reset'
    puts 'start db:seed'
    Rake::Task['db:seed'].invoke
    puts 'finished db:seed'
  end
  #namespace :categories do
  #  desc "import categories from csv file"
  #  task :import => :environment do
  #    filename = Rails.root.join('db/data/google_productsservices.csv')
  #    importer = ImportCategories.new(filename)
  #    count = importer.perform
  #    puts "imported #{count} categories"
  #  end
  #end
end
