require 'sidekiq-cron'

# cron: '0 */12 * * *',

#testing purposes = 2 minutes run
# cron: '*/2 * * * *'




job = Sidekiq::Cron::Job.create(
  name: 'Update GitHub Repos - every 12 hours',
  cron: '0 */12 * * *',
  class: 'UpdateGithubReposJob'
)

Rails.logger.info "Cron job created: #{job}"
