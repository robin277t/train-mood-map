# THIS IS A BASIC STOMP CONNECTION AS GLEANED FROM CHATGPT

require 'stomp'

client = Stomp::Client.new(
  login: 'USERNAME',
  passcode: 'PASSWORD',
  host: 'datafeeds.nationalrail.co.uk',
  port: 61613,
  ssl: true
)

client.subscribe("/topic/TRAIN_MVT_ALL_TOC")


loop do
  message = client.receive
  # process the message
end

client.close
