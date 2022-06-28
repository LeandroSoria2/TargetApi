# frozen_string_literal: true

namespace :code do
  desc 'Run code quality tools'
  task analysis: :environment do
    sh 'bundle exec rubocop .'
    sh 'bundle exec reek .'
  end
end
