if Rails.env.development? || Rails.env.test?
  require 'rubocop/rake_task'

  desc 'Run RuboCop to do code style check'
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.options = ['-DRS']
    task.fail_on_error = true
  end
end
