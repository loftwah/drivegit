module DriveGit
  module GitModule
    def self.init(repo_name = 'drivegit')
      puts "Initializing new Git repo called #{repo_name}!"
      system("git init #{repo_name}")  # Initialize new repo with provided name.
    end

    def self.clone(folder_name, download_path)
      puts "Cloning Git repo from Drive folder #{folder_name} to #{download_path}!"
      
      # Get list of all files in folder from Google Drive
      files_to_clone = DriveModule.list_files_in_folder(folder_name)
      
      # Grug check if files_to_clone empty before run .each
      if files_to_clone.nil?
        puts "No files in folder. Grug sad."
        return
      end
      
      # Do downloading magic here for each file in files_to_clone
      files_to_clone.each do |file|
        DriveModule.download_file(file.title, download_path)
      end
    
      puts "Clone magic complete! Grug happy."
    end    

    def self.push
      puts "Pushing changes to Drive!"
      # Push logic here. Maybe zip first? Dean Grug know best.
    end

    def self.pull
      puts "Pulling changes from Drive!"
      # Pull logic here. Maybe unzip after? Dean Grug decide.
    end
  end
end
