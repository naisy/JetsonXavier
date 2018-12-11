#!/bin/bash
########################################
# disable autologin
########################################
# sed
# escape characters \'$.*/[]^
# 1. Write the regex between single quotes.
# 2. \ -> \\
# 3. ' -> '\''
# 4. Put a backslash before $.*/[]^ and only those characters.

#-    AutomaticLoginEnable = true
#+    AutomaticLoginEnable = false
sed -i 's/^AutomaticLoginEnable = true/AutomaticLoginEnable = false/g' /etc/gdm3/custom.conf
