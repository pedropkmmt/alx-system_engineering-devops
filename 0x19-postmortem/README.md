Postmortem: Apache Web Server Outage on Ubuntu 14.04

Issue Summary

* Duration: 13 hours 20 minutes (from 06:00 am to 19:20 pm)—yes, that’s a long time for a missing letter.
* Impact: The Holberton WordPress site was completely down, throwing 500 Internal Server Errors at anyone who dared visit. 100% of users were affected—so, basically, everyone.
* Root Cause: A typo in wp-settings.php referenced a file that didn’t exist (class-wp-locale.phpp instead of class-wp-locale.php).*
*  That extra "p" single-handedly broke everything. Who knew one letter could wield such power?

Timeline
* 06:00 am – Outage began after the release of ALX's System Engineering & DevOps project 0x19.
* 19:20 Pm – Engineer (Pedro) detected the issue upon starting the project. "Hey, why is everything broken?" moment ensued.
* 19:30 Pm – Checked Apache processes. They were running fine—so, no blaming the server this time.
* 19:40 Pm – Verified document root settings in /etc/apache2/sites-available/. Everything looked okay… or so it seemed.
* 19:50 Pm – Ran strace on Apache’s root process while making requests—expected brilliance, got nothing useful instead.
* 20:00 Pm – Ran strace on www-data process. BOOM! Found a missing file error (ENOENT). Clue unlocked.
* 20:10 Pm – Investigated /var/www/html/wp-settings.php and found the villain: an extra “p” (.phpp). A single-letter disaster.
* 20:15 Pm – Deleted the extra “p” like it had personally offended me.
* 20:20 Pm – Retested the server. Success! The 200 OK response was back, and so was my faith in life.
* 20:30 Pm – Wrote a Puppet script to prevent future typo-related heartbreak.

Root Cause & Resolution

Root Cause

The issue was caused by a typo in wp-settings.php that mistakenly referenced class-wp-locale.phpp instead of class-wp-locale.php. This tiny mistake made WordPress panic and shut everything down—overreacting much?
Resolution

1. Found and removed the extra "p" in wp-settings.php.
2. Restarted Apache.
3. Tested the site—200 OK, back in business.
4. Created a Puppet script to automatically detect and fix similar typos in the future.

Corrective & Preventative Measures

Lessons Learned
* Test before deploying. Or risk spending hours hunting down rogue letters.
* Use monitoring tools (e.g., UptimeRobot) to scream at us when things go wrong.
* Improve code reviews. We must catch typos before they bring down an entire system.

Action Items (To-Do List)

 ✅ Add pre-deployment testing to stop typos before they cause chaos.
 
 ✅ Implement uptime monitoring alerts for instant notifications.
 
 ✅ Update code review checklists to include sanity checks for file paths.
 
 ✅ Expand the Puppet script to scan for common filename typos—because one missing letter should never ruin an entire day again.
 
With these steps, we should be safe… unless, of course, the typo strikes back. But hey, we’re programmers—we never make mistakes, right? 😉



