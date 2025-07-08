put this script in lib/tasks/ directory of the greenlight docker container

to run it execute this:

docker exec greenlight-v3 bundle exec rake 'custom:create_account[Ali,ali@example.com,Ali123@1Dr,physics-room]'
