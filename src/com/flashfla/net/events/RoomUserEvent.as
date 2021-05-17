package com.flashfla.net.events
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.flashfla.net.Multiplayer;
    import classes.Room
    import classes.User;

    public class RoomUserEvent extends TypedSFSEvent
    {
        public var user:User;
        public var room:Room;

        public function RoomUserEvent(params:Object)
        {
            super(Multiplayer.EVENT_ROOM_USER);
            user = params.user;
            room = params.room;
        }
    }
}
