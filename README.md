# clean-pc
Some helpful, system-agnostic batch scripts to clean out temp files, cache files, etc. 

These scripts aim to make cleaning out Windows and Nividia temporary or cache files easier by leveraging standard Windows envrionment variables to find and remove those files and folders in a more system-agnostic way. 

For example, if your default drive letter is `X:\` instead of `C:\` there's no need to update or change anything, it should "just work". This is still assuming that you have installed things like your Nividia drivers on to that default drive. 

These scripts are built with some basic logging that will display as they are running. When the script completes it will prompt the user to press any key to close the command prompt window. This is to allow for viewing of that logging to insure all desired files and folders were cleaned. 

All removal commands are made such that files in-use will not be removed and the user will **not** be prompted as such for any skip or y/n prompts. The scripts also take into account if the directories exists or not and will skip directories they cannot find. 

## Usage

### Run Directly

The simplest way to use these scripts is to either right-click and select 'Run as Adminstrator', or create a Shortcut to the script and configure the shortcut to run the script as an Adminstrator. 

### Scheduled Task

Another way to run these scripts would be to use the [Task Scheduler](https://docs.microsoft.com/en-us/windows/win32/taskschd/using-the-task-scheduler) in Windows to run the script(s) at a specific time, weekly, when you log on, and a few other options.  

## Scripts

### Delete_Cache_Files.bat
This script removes cache files from three directories: 

- **`%PROGRAMDATA%\NVIDIA Corporation\NV_Cache`** (Typically, "C:\ProgramData\NVIDIA Corporation\NV_Cache")
    - Nividia cache files that are _supposed_ to help with FPS in games and overall performance, but files cluttering this folder have been reported to cause stuttering and other undesireable side-effects in-game. For examples simple Google "NV_Cache". 
- **`%LOCALAPPDATA%\NVIDIA\GLCache`** (Typically, "C:\Users\\<username\>\AppData\Local\NVIDIA\GLCache")
    - OpenGL shader cache files. 
- **`%LOCALAPPDATA%\D3DSCache`** (Typically, "C:\Users\\<username\>\AppData\Local\D3DSCache") 
    - > D3DSCache is a folder that contains cached information for Microsoft's Direct3D API.
      > 
      > This is part of DirectX, which is used for graphics display in games and other intensive software. 
      > You shouldn't need to touch the files inside under normal circumstances, and they only take up a few megabytes. 
      > However, if you're experiencing game crashes that relate to graphics files, clearing this cache may be a useful step.
      >
      > -- [Ben Stegner from makeuseof.com](https://www.makeuseof.com/tag/default-windows-files-folders/)

### Delete_Temp_Files.bat
This script removes temp files from a few Windows directories: 

- **`%TEMP%`** (Typically, "C:\Users\\<username\>\AppData\Local\Temp")
	- These files are typically created by processes to store data while the process is alive and are often cleaned out when the process ends, but not always. These files can also be useful for recovering things in applications. That being said, this folder can grow over time and in some cases cause latency. In the end these files are all "temp" files and aren't expected to live long and can be deleted with minimal or no impact to the user. 
- **`%WINDIR%\Temp`** (Typically, "C:\Windows\Temp") 
    - This directory is similar to the `%TEMP%` directory in it's purpose and provided that all other applications are closed it is safe to attempt to delete all files and folders within, aside from those in-use. 
- **`%WINDIR%\SoftwareDistribution\Download`** (Typically, "C:\Windows\SoftwareDistribution\Download")
	- > The Software Distribution folder is a vital component for Windows Update, which temporarily stores files needed to install new updates. 
	  > It's safe to clear the content of the said folder because Windows 10 will always re-download and re-created all the necessary file and components, if removed.
	  >
	  > [John DeV (Microsoft Independent Advisor)](https://answers.microsoft.com/en-us/windows/forum/windows_10-files/cwindowssoftwaredistributiondownload-deleting/7121844b-82bb-4a53-ad52-3a93fcfc9ffb)
