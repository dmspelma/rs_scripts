# frozen_string_literal: true

require_relative 'services/rs_sheets'

player_name = ENV.fetch('RS_PLAYER_NAME', nil)

service = RsScripts::RsSheets.new(player_name)

# Push last 12 months of data
service.push_data((0..11).to_a)
