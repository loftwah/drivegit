require_relative 'drivegit/drive_module'
require_relative 'drivegit/git_module'

module DriveGit
  def self.info
    puts "DriveGit: Main Application"
    DriveModule.info
    GitModule.info
  end
end
