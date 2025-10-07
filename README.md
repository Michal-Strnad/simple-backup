# Simple backup script

Dependencies:
7zip - You need to install first!

If your 7zip program is installed on x86 system or in different folder, you have to change the path to 7z.
Example:
 - "C:\Program Files\7-Zip\7z" a "%destinationFolder%\%zipFile%" "%sourceFolder%" -r %excludeParams%
 - "Path to your 7z" a "%destinationFolder%\%zipFile%" "%sourceFolder%" -r %excludeParams%


Backups are voked daily by task scheduler.
Run task scheduler as administrator, create new daily task with backup-script.
!Scripts must be run under SYSTEM to work properly!

If you backup multiple times within one day, zip file is simply modified and files are added in.