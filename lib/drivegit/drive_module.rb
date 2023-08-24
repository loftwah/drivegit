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
        url = authorizer.get_authorization_url(
          base_url: 'http://localhost'
        )
        puts "Open the following URL in the browser and enter the resulting code after authorization:\n" + url
        code = $stdin.gets.chomp # Change this line
        credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: 'http://localhost'
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
      file.download_to_file(download_path)
    end

    def self.list_files
      session = authenticate
      session.files.each do |file|
        puts file.title
      end
    end
  end
end
