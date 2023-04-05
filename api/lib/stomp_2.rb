# The code for a ruby class which will poll the national rail stomp service could look similar to the below code block.

# The initialize method sets up the client. For the security_token variable, use your security key from the 'My Feeds' page.

# The run method will connect to the stomp service and subscribe to the queue. This process will run until the client is closed. When the client receeived a new message from the queue, it will print the mody of the message before sending an acknowlegement to the stomp service that the message was received.

# The shutdown method can be called to close the connection and halt the process.

#BELOW CAME FROM RUBY REPO ON OPEN RAIL DATA, APPEARS TO BE A BIT OLD THOUGH

require "stomp"
# require_relative "../ENV_VARIABLES.txt"

class NrPoller

  def initialize
    # @security_token = 'security-token-from-your-account-data-feeds-page'
    # think the above line is redundant these days
    credentials = File.readlines("ENV_VARIABLES.txt").map(&:chomp)
    @username = credentials[0]
    @password = credentials[1]
    
    @hostname = 'darwin-dist-44ae45.nationalrail.co.uk'
    # @hostname = 'datafeeds.nationalrail.co.uk'
    @port = '61613'
  end

  def run
    @client = Stomp::Client.new(@username, @password, @hostname, @port, true)
    puts @client.connection_frame.body

    @client.subscribe('/topic/darwin.pushport-v16',{id: 1, ack: 'auto' }) do |msg|
      puts msg.body
      @client.acknowledge(msg, msg.headers)
    end

    @client.join
    puts "Connected"
  end

  def shutdown
    if @client
      @client.close
    end
    puts "Disconnected"
  end

end


# The script below will create an instance of the poller class described above and then call the run method, printing any new message from the queue to the console.

# When ctrl-c is pressed, the shutdown method is called and the client disconnects cleanly.


nrPoller = NrPoller.new

begin
  nrPoller.run
rescue SystemExit, Interrupt
  nrPoller.shutdown
rescue Exception => e
  nrPoller.shutdown
  raise e
end