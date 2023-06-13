#Step 1 - Make sure C:/Temp exists (will put .ico files in there)
if (!(Test-Path -Path 'C:\Temp')){
    New-Item -ItemType Directory -Force -Path c:\Temp
}
else{}

#Step 2 - Download ICO files into previous created folder if they don't exist. *If a new image is wanted, we will incriment the names. I.E. adp2.ico.
if (!(Test-Path 'C:\Temp\ukg.ico' -PathType Leaf))
{
	Invoke-WebRequest -Uri 'https://stnormreevespublic001.blob.core.windows.net/intune/ukg.ico' -Outfile c:\temp\ukg.ico
}
else{}


#Step 3 - Add the custom URL shortcut to your Desktop with custom icon. Recreating the public desktop icons is by design. If a new image is uploaded this will be set to change. Only disk IO so not an issue.

$newObject = New-Object -ComObject WScript.Shell
$destination = $newObject.SpecialFolders.Item('AllUsersDesktop')
$sourcePath = Join-Path -Path $destination -ChildPath '\\UKG.lnk'
$source = $newObject.CreateShortcut($sourcePath)
$source.TargetPath = 'http://normreeves2u.ukg.net/'
$source.IconLocation = '\temp\ukg.ico'
$source.Save()
