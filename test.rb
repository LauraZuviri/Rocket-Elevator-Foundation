require 'slack-ruby-client'

Slack.configure do |config|
  config.token = "xoxp-340694917717-425172508807-462768836930-ef9e143279ee2d4d430a1bd5b45cce95"
end

client = Slack::Web::Client.new
client.auth_test

client.chat_postMessage(channel: '#elevator_operations', text: 'Nathan cest le meilleur aurevoir', as_user: true)