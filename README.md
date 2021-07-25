# syspectr-scripts

Publishing my own powershell scripts to be used with O&O Syspectr (app.syspectr.com), 
a free service to keep your machines under control.

There are some DEMO scripts which I wont publish here. 
They come with every instance if you decide to sign up, so there is no need.

Personally I use the service to onboard my new machines due to lack of a proper software deployment system.
It relies on chocolatey community (chocolatey.org) in most places which is a great thing in itself.

## Notice
Keep in mind that these scripts are deeply in a state of "works-for-me"!
If they don't work for you feel free to fork and adapt.
I won't do that for you.
If you feel generous you are free to propose some changes with a pull request (PR).

## Attention!
The scripts are run with system account, so no interaction possible!
If you need interaction - look elsewhere.
You can try to circumvent this by using scheduled tasks that the user may interact with, 
but that is just an idea I had when struggling with some of my scripts.
I have not tried this - at all!
