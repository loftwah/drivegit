# DriveGit

![DriveGit](https://github.com/loftwah/drivegit/assets/19922556/6b63ed33-eaa2-4e50-ab38-99dca48d809f)

DriveGit is a fantastic yet terrifying idea that serves as an adapter between Git and Google Drive. Yes, you heard right, store your code in Google Drive and watch devs make sour face!

## How it works

1. You need a `credentials.json` in root directory. Get it [here](https://developers.google.com/drive/api/v3/quickstart/js).
2. `token.yaml` file also needed in root directory. Don't worry, DriveGit make for you!

## Features

### What it has

- Google Drive list: List all files and directories. DriveGit magic make it easy!
- Google Drive download: Grug say download important. Bring files from Drive cave to local cave.
- Google Drive upload: Send files to big Drive cloud. Keep safe from T-Rex.

### What it can do soon (Todo)

- **Initialize a New Git Repository**: Make new Git magic box and send to Google Drive.
- **Clone a Git Repository**: Bring whole magic box from Google Drive to local cave.
- **Push Changes**: Make changes in local magic box. Send changes to Drive cave.
- **Pull Changes**: Get updates from Drive cave magic box to local cave magic box.
- **Branch Management**: Create, list, delete, and switch magic wands (branches).
- **Tag Management**: Make special marks on magic box. Easy find later.
- **Conflict Resolution**: Fix fights between local and Drive cave magic. No more Grug angry.

## How to Use

### Clone a Repo

```bash
bin/drivegit clone your_folder_name_on_drive
```

This will bring the magic box called your_folder_name_on_drive from Google Drive cave to local cave (./ by default).

### Initialize a Repo

```bash
bin/drivegit init your_new_repo_name
```

This will create a new empty magic box with the name your_new_repo_name and send it to Google Drive cave.

