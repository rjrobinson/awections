class AuctionSocket

	def initialize app
		@app = app
		# @clients = []
	end

	def call env
		@env = env
		if socket_request?
			socket = Faye::WebSocket.new env
			socket.rack_response

			socket.on :open do
				socket.send "Connected"
			end
		else
			@app.call env
		end
	end

	private

	attr_reader :env

	def socket_request?
		Faye::WebSocket.websocket? env
	end
end
