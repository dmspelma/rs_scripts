# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'
require 'rs_api'
require_relative 'sheets'

module RsScripts
  # Class for pushing Runescape player data to a Google Spreadsheet
  class RsSheets < Sheets
    attr_reader :player

    def initialize(player)
      @player = RsApi::MonthlyXp.new(player)
    end

    def push_data(months)
      months.each do |mo|
        csv_data = csv_data_for_month(mo)
        sheet = sheet_name(mo)

        handle_create_sheet(sheet)
        handle_push_data(sheet, csv_data)
      end
    end

    private

    def application_name
      'rs_scripts'
    end

    def credential_file
      @credential_file ||= ENV.fetch('RS_GOOGLE_CRED_FILE_PATH', nil)
    end

    def csv_data_for_month(month)
      csv_data = [['Skill', 'Xp Gained']]

      player.raw_data.each do |skill_data|
        csv_data << [
          skill_data[0].to_s.capitalize, # Skill name
          skill_data.last['monthData'][month]['xpGain'].to_i # Second to last is previous month
        ]
      end

      csv_data
    end

    def handle_create_sheet(sheet)
      create_response = create_new_sheet(sheet)
      create_sheet_name = create_response.replies.first.add_sheet.properties.title
      success_msg = 'New sheet '.green + sheet.cyan + ' created successfully'.green
      puts success_msg if create_sheet_name == sheet
      # Future: Put check here in case pushing data to existing sheet?
    end

    def handle_push_data(sheet, csv_data)
      push_response = push_to_sheet(sheet, csv_data)
      puts 'Push to Google Sheets successful'.green if push_response.updated_cells >= 60
    end

    def sheet_name(month)
      # Grab previous year and previous month for sheet name
      # This endpoint only holds last 12 months of data
      (11 - month).month.ago.strftime('%Y | %B')
    end

    def spreadsheet_id
      @spreadsheet_id ||= ENV.fetch('RS_GOOGLE_SHEET_ID', nil)
    end
  end
end
