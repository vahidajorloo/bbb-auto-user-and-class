echo "copying sample text" 
cat ./sample > ./room-c.rb
sed -i "s/roomname/$room_name/g" room-c.rb
bin/rails runner ./room-c.rb
