class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    user = User.find_by(email:data['email'])

    if mmessage = Message.create(content:data['message'],user_id:user.id)
      ActionCable.server.broadcast'room_channel',{message:data['message'],name:user.name,created_at:message.created_at}
    end
  end
end
