@echo off
set destination=E:\FRA_ROCKY8
set source=\\192.168.2.67\rocky_fra
xcopy /E /I %source% %destination%
