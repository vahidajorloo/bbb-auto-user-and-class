namespace :custom do
  desc 'Create user and room, assign room ownership, then rename friendly_id'
  task :create_account, [:name, :email, :password, :room_name] => :environment do |_task, args|
    name = args[:name]
    email = args[:email]
    password = args[:password]
    room_name = args[:room_name]

    unless name && email && password && room_name
      puts "Usage: rake custom:create_account[name,email,password,room_name]"
      exit 1
    end

    # Find the Teacher role
    role = Role.find_by(name: 'Teacher')
    unless role
      puts "❌ Role 'Teacher' not found."
      exit 1
    end

    # Create user
    user = User.new(
      name: name,
      email: email,
      password: password,
      role: role,
      provider: role.provider,
      verified: true,
      status: :active,
      language: I18n.default_locale
    )

    if user.save
      puts "✅ User created: #{user.name} (#{user.email})"
    else
      puts "❌ User creation failed: #{user.errors.full_messages.join(', ')}"
      exit 1
    end

    # Create room
    room = Room.find_or_initialize_by(user: user, name: room_name)

    if room.new_record?
      if room.save
        puts "✅ Room created: #{room.name} (ID: #{room.id}, original friendly_id: #{room.friendly_id})"
      else
        puts "❌ Room creation failed: #{room.errors.full_messages.join(', ')}"
        exit 1
      end
    else
      puts "ℹ️ Room already exists: #{room.name} (ID: #{room.id}, friendly_id: #{room.friendly_id})"
    end

    # Update friendly_id after creation
    if room.friendly_id != room_name
      room.update(friendly_id: room_name)
      puts "🔁 Updated room friendly_id to: #{room.friendly_id}"
    end

    exit 0
  end
end
