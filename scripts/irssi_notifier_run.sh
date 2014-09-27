#!/bin/sh

irssi_notifier() {
   	ssh andebor@borudweb.com 'echo -n "" > ~/.irssi/fnotify; tail -f ~/.irssi/fnotify' | \
       	while read heading message; do
           	url=`echo \"$message\" | grep -Eo 'https?://[^ >]+' | head -1`;

						if [ ! "$url" ]; then
							/usr/local/bin/terminal-notifier -title "\"$heading\"" -sound "default" -message "\"$message\"" -activate com.googlecode.iterm2;
						else
							/usr/local/bin/terminal-notifier -title "\"$heading\"" -sound "default" -message "\"$message\"" -open "\"$url\"";
						fi;
				done
	}

irssi_notifier;
