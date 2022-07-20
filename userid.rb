f = File.new('user_id.out', 'w');f << User.find_by(email: "sadas@rwaefa.com").id;f.close
