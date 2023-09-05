# frozen_string_literal: true

require 'google_drive'

session = GoogleDrive::Session.from_config('config.json')

# Uploads a local file.
session.upload_from_file('users.zip', 'users.zip', convert: false)
