put this script in lib/tasks/ directory

to run it execute this:

docker exec greenlight-v3 bundle exec rake 'custom:create_account[Ali,ali@example.com,Ali123@1Dr,physics-room]'
