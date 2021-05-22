package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.Room;
    import com.smartfoxserver.v2.entities.User;

    public class UserExitRoomSFSEvent extends TypedSFSEvent
    {
        private var _user:User;
        private var _room:Room;

        public function UserExitRoomSFSEvent(params:Object)
        {
            super(SFSEvent.USER_EXIT_ROOM);

            _user = params.user;
            _room = params.room;
        }
    }
}
