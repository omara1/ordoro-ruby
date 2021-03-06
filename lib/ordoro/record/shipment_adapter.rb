module Ordoro
  module Record
    class ShipmentAdapter < BaseAdapter

      def update_request_path(record)
        "#{record_path}#{record.shipment_id}/"
      end

      def create_dropship(record, dropshipper_id)
        request_path = "#{update_request_path(record)}dropship/#{dropshipper_id}/"
        body_json = record.as_json
        body_json.delete(:assigned_to_id)
        request_params = {
          body: body_json,
          raise_errors: false
        }
        response = request(:post, request_path, request_params)
        handle_response(record, response)
      end

    end
  end
end
