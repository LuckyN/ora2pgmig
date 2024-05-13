@echo off
setlocal enabledelayedexpansion

set "source_file=ora2pg.conf"

for %%d in ("CATALOGUE" "AUDITING" "LOG" "HOSTTOHOST" "EXPORTDATA" "BILLING" "CHECKOUT" "MEDIATION" "NUMBERS" "PROMOTION" "REPORTS" "SCHEDULING" "SECURITY" "SMSC" "TELEPHONY" "VOUCHERS") do (
  
    copy "%source_file%" "%%d\"
)

endlocal
