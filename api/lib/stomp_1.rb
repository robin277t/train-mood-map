##BELOW CODE IS AN UNPROVEN CHATGPT TRANSLATION OF THE UP TO DATE ACTIVEMQ / STOMP PROTOCAL IN PYTHON TO GET THE DARWIN PUSH PORT DATA

require 'stomp'
require 'zlib'
require 'stringio'
require 'socket'
require 'logger'

USERNAME = ''
PASSWORD = ''
HOSTNAME = 'darwin-dist-44ae45.nationalrail.co.uk'
HOSTPORT = 61613
TOPIC = '/topic/darwin.pushport-v16'

CLIENT_ID = Socket.gethostname
HEARTBEAT_INTERVAL_MS = 15000
RECONNECT_DELAY_SECS = 15

LOGGER = Logger.new(STDOUT, level: :info)

if USERNAME.empty?
  LOGGER.error('Username not set - please configure your username and password!')
  exit(-1)
end

def connect_and_subscribe(connection)
  connect_header = {'client-id' => "#{USERNAME}-#{CLIENT_ID}"}
  subscribe_header = {'activemq.subscriptionName' => CLIENT_ID}

  connection.start
  connection.connect(username: USERNAME, passcode: PASSWORD, headers: connect_header)
  connection.subscribe(destination: TOPIC, id: '1', ack: 'auto', headers: subscribe_header)
end

class StompClient < Stomp::Client
  def on_heartbeat
    LOGGER.info('Received a heartbeat')
  end

  def on_heartbeat_timeout
    LOGGER.error('Heartbeat timeout')
  end

  def on_error(frame)
    LOGGER.error(frame.body)
  end

  def on_disconnected
    LOGGER.warn("Disconnected - waiting #{RECONNECT_DELAY_SECS} seconds before exiting")
    sleep RECONNECT_DELAY_SECS
    exit(-1)
  end

  def on_connecting(host_and_port)
    LOGGER.info("Connecting to #{host_and_port[0]}")
  end

  def on_message(frame)
    LOGGER.info(frame.body)
    begin
      LOGGER.info("Message sequence=#{frame.headers['SequenceNumber']}, type=#{frame.headers['MessageType']} received")
      bio = StringIO.new
      bio.write('utf-16'.encode('utf-16le'))
      bio.seek(0)
      msg = Zlib::Inflate.new(Zlib::MAX_WBITS | 32).inflate(frame.body)
      LOGGER.debug(msg)
      obj = PPv16::CreateFromDocument(msg)
      LOGGER.info("Successfully received a Darwin Push Port message from #{obj.ts}")
      LOGGER.debug("Raw XML=#{msg}")
    rescue => e
      LOGGER.error(e.message)
    end
  end
end

conn = Stomp::Client.new(hosts: [{host: HOSTNAME, port: HOSTPORT}], heartbeat: [HEARTBEAT_INTERVAL_MS, HEARTBEAT_INTERVAL_MS])
connect_and_subscribe(conn)

while true
  sleep 1
end

conn.close