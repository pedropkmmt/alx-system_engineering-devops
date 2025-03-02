Postmortem: Apache Web Server Outage on Ubuntu 14.04

Issue Summary

Duration: The outage lasted approximately 13 hours 20 minutes, from 06:00 am GMT+2 to 19:20 pm GMT+2

Impact: Users accessing the Holberton WordPress site experienced 500 Internal Server Errors. The entire service was unavailable during this period. Estimated 100% of users were affected.
Root Cause: A typo in wp-settings.php caused the application to reference a non-existent file (class-wp-locale.phpp instead of class-wp-locale.php), leading to a critical application failure.

Timeline

* 06:00 am– Outage began after the release of ALX's System Engineering & DevOps project 0x19.
* 19:20 pm– Issue detected by an engineer (Pedro) upon starting the project.
* 19:30 pm– Checked Apache processes; confirmed Apache was running.
* 19:40 pm– Verified document root settings in /etc/apache2/sites-available/.
* 19:50 pm– Used strace on Apache’s root process while making requests—found no useful information.
* 20:00 pm– Ran strace on www-data process and discovered a missing file error (ENOENT).
* 20:10 pm– Investigated /var/www/html/wp-settings.php, located a typo (.phpp instead of .php).
* 20:15 pm– Fixed the typo and restarted Apache.
* 20:20 pm– Retested the server; confirmed service was restored (200 OK response).
* 20:30pm – Created a Puppet script to prevent recurrence by detecting and correcting similar typos.

Root Cause & Resolution

Root Cause

The issue was caused by a typo in the wp-settings.php file, where a WordPress system file (class-wp-locale.php) was incorrectly referenced with an extra "p" (class-wp-locale.phpp). This led to the application failing to load, resulting in a 500 Internal Server Error for all users.
Resolution
Located the typo in wp-settings.php (line 137).
Corrected the filename from class-wp-locale.phpp to class-wp-locale.php.
Restarted the Apache server.
Verified that the WordPress site was functioning correctly.
Developed a Puppet manifest to automatically detect and fix similar typos in wp-settings.php in the future.

Corrective & Preventative Measures

Improvements & Fixes
Implement automated testing before deployment to catch such issues early.
Set up real-time monitoring (e.g., UptimeRobot) to detect outages immediately.
Improve code review processes to avoid typos in critical files.
Automate typo detection in configuration files.
Action Items (To-Do List)
Add a pre-deployment testing step for WordPress applications.
  Implement uptime monitoring alerts for website failures.
  Update code review checklists to include validation of file references.
  Expand the Puppet script to scan for common filename typos in WordPress files.
With these measures in place, we expect to prevent similar outages in the future. But of course, programmers never make mistakes.


