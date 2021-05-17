package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import classes.Room
    import classes.User;

    public class JoinedRoomSFSEvent extends TypedSFSEvent
    {
        public var room:Room;
        public var users:Vector.<User>;

        public function JoinedRoomSFSEvent(params:Object)
        {
            super(SFSEvent.onJoinRoom);
            room = params.room;
            users = params.users
        }
    }
}
