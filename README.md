# The Decisioninator: You've Found It!

So, you saw the [Decisioninator YouTube Video](https://www.youtube.com/watch?v=Qo7hUsJqTZI) and thought, "I need one of those in my life!" Well, you've come to the right place. This repo contains all the files I used to build my Decisioninator.

## The Fine Print (License)

My original code and assets in this repo are licensed under the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-nc-sa/4.0/) license.

Everything else (like the Flame game engine) belongs to its original creators and is subject to their licenses.

## A Quick Word for Potential Employers

If you're here from the future, please don't judge my coding skills by this project. The Decisioninator was a passion project, a labor of love, and frankly, a bit of a Frankenstein's monster. I never planned to share it, but the people have spoken! They wanted to build their own, and who am I to stand in the way of creative genius?

## "Shut Up and Take My Money!"

I've been blown away by the number of people who want to buy a Decisioninator. While I'm not ruling out selling them in the future, my focus right now is on creating more awesome projects for your viewing pleasure.

Besides, you deserve better. The original prototype is now held together with industrial-grade staples (long story). If I were to do it all again, I'd give it a slick 3D-printed enclosure. I've learned a ton since then, as you can see in my [Flip Puck video](https://www.youtube.com/watch?v=HGx43u8oE0w) (I'm super proud of that one!).

## Let's Build a Decisioninator!

Ready to build your own oracle of indecision? Awesome! I'm thrilled to share my code with you. But before you dive in, a few things to keep in mind:

* **This Code is a Time Capsule:** It won't run on modern Flutter. You'll need to run `flutter pub upgrade --major-versions` to get everything up to date. You might have some migration work to do after that.

* **Audio Upgrade Recommended:** You'll probably notice some stuttering. Originally I thought it was the Pi, but it was actually `flame_audio` running out of audio channels. I've had much better luck with `flutter_soloud` in more recent projects.

* **Get Your Pi Ready:** Check out the [flutter-pi](https://github.com/ardera/flutter-pi) project to set up your Raspberry Pi. I recommend using Raspberry Pi OS Lite if you're new to this.

* **Other Stuff!:** You'll find the CAD files (Fusion) and art assets in the `_resources` folder. Feel free to use them, but don't be afraid to design a better enclosure. As I mentioned, I've come a long way in two years!

I hope this helps. Now go forth and create! Have fun! :)