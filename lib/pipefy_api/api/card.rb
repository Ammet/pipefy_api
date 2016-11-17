module PipefyAPI
  module API
    module Card
      def get_card(card_id)
        response = connection.get("/cards/#{card_id}")

        PipefyAPI::Card.new(response.body)
      end

      def required_fields
        pipe = get_pipe(pipe_id)
        first_phase = get_phase(pipe.phases.first['id'])
        first_phase.fields
      end

      def create_card(pipe_id, attributes)
        first_phase = get_first_pipe_phase(pipe_id)
        fields = first_phase.fields

        response = connection.post(
          "/pipes/#{pipe_id}/create_card",
          card: { field_values: field_values(attributes, fields) }
        )

        if response.status.in? [200, 201]
          PipefyAPI::Card.new(response.body)
        else
          raise response.body
        end
      end

      private

      def get_field_id(fields, label)
        fields.detect do |field|
          if field['label'].present?
            field['label'].strip.downcase == label.downcase
          end
        end.try(:[], 'id')
      end

      def field_values(attributes, fields)
        attributes.map do |key, value|
          next if get_field_id(fields, key).blank?
          { field_id: get_field_id(fields, key), value: value }
        end.compact
      end
    end
  end
end
