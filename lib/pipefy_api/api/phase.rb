module PipefyAPI
  module API
    module Phase
      def get_phase(phase_id)
        response = connection.get("/phases/#{phase_id}.json")

        PipefyAPI::Phase.new(response.body)
      end

      def get_first_pipe_phase(pipe_id)
        pipe = get_pipe(pipe_id)
        phase_id = pipe.phases.first['id']

        get_phase(phase_id)
      end
    end
  end
end
