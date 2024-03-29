require 'sinatra'
require 'google_drive'
require 'googleauth'
require 'googleauth/stores/file_token_store'

module DriveGit
  module DriveModule
    def self.authenticate
      config_path = File.expand_path("../../../credentials.json", __FILE__)
      client_id = Google::Auth::ClientId.from_file(config_path)
      scope = ["https://www.googleapis.com/auth/drive"]

      token_store_path = File.expand_path("../../../token.yaml", __FILE__)
      token_store = Google::Auth::Stores::FileTokenStore.new(file: token_store_path)

      authorizer = Google::Auth::UserAuthorizer.new(client_id, scope, token_store)
      user_id = 'default'
      credentials = authorizer.get_credentials(user_id)

      if credentials.nil?
        code = nil

        get '/' do
          code = params['code']
          'Code received. You may close this page.'
          # Here you might want to handle the code and shut down Sinatra, depending on your needs
        end

        url = authorizer.get_authorization_url(
          base_url: 'http://localhost:4567'
        )

        puts "Open the following URL in the browser and enter the resulting code after authorization:\n" + url

        sleep 1 while code.nil?

        credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: 'http://localhost:4567'
        )
      end

      raise "No credentials available" unless credentials
      session = GoogleDrive::Session.from_credentials(credentials)

      session
    end

    def self.upload_file(filepath)
      session = authenticate
      session.upload_from_file(filepath, File.basename(filepath), convert: false)
    end

    def self.download_file(filename, download_path)
      session = authenticate
      file = session.file_by_title(filename)
      file_id = file.id

      drive_service = session.drive_service
      dest_path = File.join(download_path, filename)

      File.open(dest_path, 'wb') do |file_io|
        drive_service.get_file(file_id, download_dest: file_io)
      end

      puts "File downloaded to #{dest_path}"
    end

    def self.list_directories
      session = authenticate
      session.files.each do |file|
        if file.mime_type == 'application/vnd.google-apps.folder'
          puts "Directory: #{file.title}"
        end
      end
    end

    def self.list_files
      session = authenticate
      session.files.each do |file|
        puts file.title
      end
    end

    def self.list_files_in_folder(folder_name)
      session = authenticate
      folder = session.collection_by_title(folder_name)
    
      if folder.nil?
        puts "No such folder: #{folder_name}. Grug sad."
        return
      end
    
      folder.files.each do |file|
        puts file.title
      end
    end    

  end
end
