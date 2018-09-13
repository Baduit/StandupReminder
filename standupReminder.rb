#!/usr/bin/env ruby

require 'pathname'
require 'date'

class ReminderFile
	def initialize(filename)
		@filename = Pathname.new(filename).basename
		@text = File.read(filename)
		@date = Date.parse(Pathname.new(filename).basename("rb").to_s)
		rescue ArgumentError
			@date = nil
	end
	
	def date()
		return @date
	end

	def show()
		puts("-" * 80)
		puts(@date.day.to_s + "-" + @date.month.to_s + "-" + @date.year.to_s)
		puts("-" * 80)
		puts(@text)
	end
end

def createDirIfNotExist(dirname)
	if !Dir.exists?(dirname) then
		Dir.mkdir(dirname)
	end
end

def getLastFilename(dirname)
	file = ""
	d = nil
	Dir.foreach(dirname) do |f|
		name = Pathname.new(f).basename(".txt").to_s
		date = Date.parse(name)
		
		if d == nil || date > d then
			d = date
			file = f
		end
	rescue ArgumentError
	end
	if file != ""
		return dirname + "/" + file
	else
		return ""
	end
end

def showAllFiles(dirname)
	fileList = []
	Dir.foreach(dirname) do |f|
		filename = dirname + "/" + f;
		if File.file?(filename) then
			rf = ReminderFile.new(filename)
			if rf.date != nil then
				fileList.push(rf)
			end
		end
	end

	fileList = fileList.sort_by { |f| f.date }.reverse

	fileList.each do |f|
		f.show
	end
end

def showFile(filename)
	if filename == "" then
		puts("Sorry, no reminder available.")
	else
		ReminderFile.new(filename).show()
	end
end

def writeToFile(filename, content)
	f = File.open(filename, 'a')
	content.each do |str| 
		f.write(str + " ")
	end
	f.puts("")
end

def resetTodayFile(filename)
	f = File.open(filename, 'w')
	f.puts("")
end

def deleteTodayFile(filename)
	if File.exists?(filename) then
		File.delete(filename)
	end
end

def deleteAllFiles(dirname)
	fileList = []
	Dir.foreach(dirname) do |f|
		filename = dirname + "/" + f;
		if File.file?(filename) then
			File.delete(filename)
		end
	end
end

def main
	filesDirectory = Dir.home + "/.StandupReminder"
	todayFilename =  filesDirectory + "/" + Date.today.day.to_s + "-" + Date.today.month.to_s + "-" + Date.today.year.to_s + ".txt"

	createDirIfNotExist(filesDirectory)
	if ARGV.size == 0 || (ARGV.size == 1 && ARGV[0] == "recap") then
		showFile(getLastFilename(filesDirectory))
	elsif ARGV.size == 1 && ARGV[0] == "log" then
		showAllFiles(filesDirectory)
	elsif ARGV.size == 1 && ARGV[0] == "reset" then
		resetTodayFile(todayFilename)
	elsif ARGV.size == 1 && ARGV[0] == "delete" then
		deleteTodayFile(todayFilename)
	elsif ARGV.size == 1 && ARGV[0] == "delete-all" then
		deleteAllFiles(filesDirectory)
	else
		writeToFile(todayFilename, ARGV)
	end
end

main