
# config
configure retention policy to recovery window of 7 days;



# report
report need backup;
report obsolete;

list archivelog all backed up 1 times to DISK;



# backup



# delete
delete archivelog all backed up 1 times to device type disk;
delete obsolete;
