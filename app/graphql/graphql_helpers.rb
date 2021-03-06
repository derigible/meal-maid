# frozen_string_literal: true

#
# Copyright (C) 2018 - present Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

module GraphqlHelpers
  class << self
    UrlHelpers = Rails.application.routes.url_helpers

    # this function allows an argument to take ids in the graphql global form or
    # standard canvas ids. the resolve function for fields using this preparer
    # will get a standard canvas id
    def relay_or_legacy_id_prepare_func(expected_type)
      proc do |relay_or_legacy_id, _ctx|
        begin
          parse_relay_or_legacy_id(relay_or_legacy_id, expected_type)
        rescue InvalidIDError => e
          GraphQL::ExecutionError.new(e.message)
        end
      end
    end

    def relay_or_legacy_ids_prepare_func(expected_type)
      proc do |relay_or_legacy_ids, _ctx|
        begin
          relay_or_legacy_ids.map do |relay_or_legacy_id, _ctx|
            parse_relay_or_legacy_id(relay_or_legacy_id, expected_type)
          end
        rescue InvalidIDError => e
          GraphQL::ExecutionError.new(e.message)
        end
      end
    end

    def parse_relay_or_legacy_id(relay_or_legacy_id, expected_type)
      if relay_or_legacy_id.nil? || relay_or_legacy_id =~ /\A\d+\Z/
        relay_or_legacy_id
      else
        type, id = GraphQL::Schema::UniqueWithinType.decode(relay_or_legacy_id)
        raise InvalidIDError.new("expected an id for #{expected_type}") if type != expected_type || id.nil?

        id
      end
    end

    class InvalidIDError < StandardError; end
  end
end
