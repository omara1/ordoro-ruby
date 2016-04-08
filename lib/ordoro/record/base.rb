require 'ordoro/helpers/serialization_helper'
require 'ordoro/helpers/validation_helper'
module Ordoro
  module Record
    class Base
      include Virtus.model
      include Ordoro::Helpers::SerializationHelper
      include Ordoro::Helpers::ValidationHelper

      attribute :id, Integer, readonly: true
      attribute :created, DateTime, readonly: true
      attribute :updated, DateTime, readonly: true
      attribute :client, Ordoro::Client, readonly: true

      def initialize(attributes={})
        @client = attributes.delete('client')
        super(attributes)
      end

      def persisted?
        !!id
      end

      def save
        @client.adapter_for(self.class.demodulized_name).save(self)
      end

      def find(id)
        fetch(id)
      end

      def find_many(ids)
        ids.map {|id| find(id) }
      end

      private

      def json_root
        @model_name.to_s.underscore
      end

      def self.demodulized_name
        self.name.split('::').last
      end

    end
  end
end