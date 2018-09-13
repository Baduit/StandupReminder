# StandupReminder

## Description
A simple tool to help you to now what you have to say during your daily standup meeting.

## How to use it?
You need to have a ruby interpreter installed, then execute the script.

Here a few examples.
``` Shell
./standupReminder.rb Hey guys # Write "Hey guys"

./standupReminder.rb "What's up" # Write "What's up"

./standupReminder.rb # show you what you have written with the date
----------------------------------------
13-9-2018
----------------------------------------
Hey guys 
What's up 

./standupReminder.rb log # show everything you have writting with this tools from the most recent to the oldest

./standupReminder.rb reset # erase what you have written today

./standupReminder.rb delete # delete the file containing today's work

./standupReminder.rb delete-all # erase all the files created by this tool


```

## Is it cross-platform?
I only tried it on linux, but it should work on windows.
