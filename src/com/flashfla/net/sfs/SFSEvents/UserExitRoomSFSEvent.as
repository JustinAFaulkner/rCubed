package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.Room;
    import com.smartfoxserver.v2.entities.User;
    import flash.events.Event;

    public class UserExitRoomSFSEvent extends TypedSFSEvent
    {
        private var _user:User;
        private var _room:Room;
        private var _isMe:Boolean;

        public function get isMe():Boolean
        {
            return _isMe;
        }

        public function UserExitRoomSFSEvent(user:User, room:Room, isMe:Boolean)
        {
            super(SFSEvent.USER_EXIT_ROOM);

            _user = user;
            _room = room;
            _isMe = isMe;
        }

        public override function clone():Event
        {
            return new UserExitRoomSFSEvent(this._user, this._room, this._isMe);
        }
    }
}
