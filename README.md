# OXP Packaging Scripts

These are my scripts for easily packaging and testing
OXPs/OXZs. They're available in case anyone else wants to use or adapt
them, as they've made things much easier for me. Advantages:

* No need to shift-restart during development, so you can get quicker
  from-cache startup the rest of the time.
  
* Update the version in one place, have it propagate everywhere
  else. This is less useful now that the version in `manifest.plist`
  can automatically fill in the version in JS files, but it's still
  useful.

* Provides a common JS script header.

* Automatically builds well-packaged OXPs and OXZs.

* Automatically runs the OXP verifier (with a little bit of work)

They work with the Linux install locations; they will need some
modification to work on Windows or Mac.

## Licensing

The scripts themselves can be treated as public domain, so while small
bits of output from the scripts and files from the templates will end
up in your OXPs, that doesn't imply any particular license is required
by you, or that you need to credit me at all.

As usual, provided as-is, no warranty of any sort whatsoever.

## Usage

These scripts will need a bit of work before you can make good use of
them. Make sure you install them somewhere outside where Oolite might
look for OXPs - I use `~/myaddons` but it doesn't really matter as
long as it's not `~/.Oolite/AddOns` or similar.

### Before using it the first time

1) Update the `template/scriptheader.js` file to use your own name and
copyright year.

2) Update the `template/License.txt` file to specify the license you
release the majority of your OXPs with.

3) If there are any other files you want to include in every OXP, put
them in `template/oxp`. While you will want to include a
`manifest.plist`, it's probably easier to build that using the
manifest editor on the Oolite website.

4) Optional, but strongly recommended: edit the last line of
`buildscript.common` to point to your install of the OXP Developer
(aka test) build of Oolite. This will enable OXP verification which
will pick up on some of the more obvious syntax errors without having
to start the full Oolite and poke through the Latest.log.

### To make a new OXP

1) Copy the 'template' directory to a directory named after the OXP (e.g. `cp -r template MyOxp`). The folder must be at the same level as the `template` folder (if it isn't, you'll need to edit `buildscript.sh` a bit more)

2) Edit the `buildscript.sh` file in the new folder to set the OXPNAME
and VERSION variables.

3) Write the contents of your OXP in the 'oxp' subfolder.

4) Run the `buildscript.sh` script from the MyOxp folder. This will:

* Build the OXP in a 'buildtmp' folder

* Removes `*~` files from the 'buildtmp' folder and subfolders. If
  your editor indicates backup files in a different way, you might
  want to modify `buildscript.common` a little.

* Copy in the readme and License files from the MyOxp folder

* Place the contents of `scriptheader.js` at the top of every file in
  `oxp/Scripts`.

* Copy the `requires.plist` and `manifest.plist` in the 'oxp' folder,
  and replace any occurrence of the string VERSION in the manifest.plist
  with the VERSION variable in `buildscript.sh`

* Install the OXP, in OXZ format, to your `~/.Oolite/AddOns`
  folder. This is an updated file timestamp, even if it was already
  there, so you won't need to shift-restart Oolite to pick it up. If
  you've done this already it will overwrite the existing one.

* Make an OXPNAME_VERSION.zip file containing the OXP in OXP format
  and put it in the MyOXP folder.
  
* Make an OXPNAME_VERSION.oxz file and put it in the MyOXP folder

5) Start Oolite, test your OXP, fix the bugs, then run
`buildscript.sh` again.

6) Once you've got it working, upload the version-numbered OXP and/or
OXZ to the internet.

### To update an OXP

Very easy: open `buildscript.sh` and increase the version number, then
go to step 3 above.

### Advanced use

For Rescue Stations OXP, when I was maintaining that, I had a second script that built the `shipdata.plist` (and its massive list of `like_ship` entries to allow OXP ships to be used if installed) from a bunch of templates. If you have something like that, edit `buildscript.sh` to put it just before the call to `../buildscript.common`

OXP verification is currently a lot more comprehensive in the 1.81
nightly builds than in the 1.80 release. You can install a nightly
build, point the OXP verifier line at that executable, and play+test
OXPs on 1.80 as before without trouble.
