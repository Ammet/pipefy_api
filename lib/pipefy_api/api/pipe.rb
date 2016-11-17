module PipefyAPI
  module API
    module Pipe
      def get_pipe(pipe_id)
        response = connection.get("/pipes/#{pipe_id}")

        PipefyAPI::Pipe.new(response.body)
      end
    end
  end
end
