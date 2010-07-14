how to set up an ssh tunnel to do fb-related dev
step 1: 
alias fbtunnel='ssh altay@mightyquiz.com -p22 -N -R *:4007/localhost/4007'

step 2: 
script/server -p 4007

step 3:
go to http://www.mightyquiz.com:4007/
