@echo off
setlocal enabledelayedexpansion

for %%d in ("CATALOGUE" "AUDITING" "LOG" "HOSTTOHOST" "EXPORTDATA" "BILLING" "CHECKOUT" "MEDIATION" "NUMBERS" "PROMOTION" "REPORTS" "SCHEDULING" "SECURITY" "SMSC" "TELEPHONY" "VOUCHERS") do (
    mkdir "%%d"
)

endlocal
