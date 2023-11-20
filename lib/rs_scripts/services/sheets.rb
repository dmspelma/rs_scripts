# frozen_string_literal: true

require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'

# Base Class for interacting with and uploading to Google Sheets
class Sheets
  def create_new_sheet(title)
    new_sheet = Google::Apis::SheetsV4::AddSheetRequest.new(
      properties: Google::Apis::SheetsV4::SheetProperties.new(title:)
    )
    requests = [Google::Apis::SheetsV4::Request.new(add_sheet: new_sheet)]

    batch_update_request = Google::Apis::SheetsV4::BatchUpdateSpreadsheetRequest.new(requests:)
    sheet_service.batch_update_spreadsheet(spreadsheet_id, batch_update_request)
  end

  def push_to_sheet(sheet_range, csv_data)
    sheet_service.update_spreadsheet_value(
      spreadsheet_id,
      sheet_range,
      value_range(csv_data),
      value_input_option: 'RAW'
    )
  end

  private

  def application_name
    'implement me!'
  end

  def authorizer
    raise StandardError, 'missing google sheets api credential file' if credential_file.nil?

    Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(@credential_file),
      scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS
    )
  end

  def credential_file
    'implement me!'
  end

  def sheet_service
    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = application_name
    service.authorization = authorizer
    service
  end

  def spreadsheet_id
    'implement me!'
  end

  def value_range(data)
    Google::Apis::SheetsV4::ValueRange.new(values: data)
  end
end
