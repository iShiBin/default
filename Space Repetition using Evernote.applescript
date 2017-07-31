tell application "Evernote"
	(*
	To implment a space repetition using Evernote, I develop this script to:
	- Find notes with tag "reflect" after 1/2/10/30/60 days after its creation time
	- Tag these notes with "practice" every night before reviewing
	- Actions on Evernote side:
		- daily review notes with tag "practice" and untag them after review
		- in the last time of practice, mark the note with 'echo' for one more review after 30 days
	*)
	
	set holiday to 0
	set holiday to text returned of (display dialog "How many days have you missed practice?" default answer "0" buttons {"OK"} default button 1)
	try
		set holiday to holiday as integer
	on error
		display dialog "Number Only!" with title "Error" buttons {"OK"} default button 1
		return
	end try
	
	set interval to {1, 2, 10, 30, 60} as list
	repeat with i in interval
		set start_day to i - 1 - holiday as string
		set end_date to i as string
		set search_string to "tag:reflect created:day-" & start_day & "-created:day-" & end_date & "-tag:mastered" as string
		set notelist to find notes search_string
		if (count of notelist) is greater than 0 then
			assign tag "practice" to notelist
		end if
	end repeat
	
	(*
	If I still could not recall on the last practice (60 days), 
	tag this note with 'echo' and prepare for a further review after 30 days.
	So this section is to query these notes and put them in the practise queue for one more time.
	*)
	
	set i to i + 30
	set start_day to i - 1 - holiday as string
	set end_date to i as string
	set search_string to "tag:echo created:day-" & start_day & "-created:day-" & end_date & "-tag:mastered" as string
	set notelist to find notes search_string
	if (count of notelist) is greater than 0 then
		assign tag "practice" to notelist
	end if
	
	-- display the practice queue, and start to learn!
	set query string of window 1 to "tag:practice -tag:mastered"
	
end tell