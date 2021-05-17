package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import classes.Room

    public class RoomAddedSFSEvent extends TypedSFSEvent
    {
        public var room:Room;

        public function RoomAddedSFSEvent(params:Object)
        {
            super(SFSEvent.onRoomAdded);
            room = params.room;
        }
    }
}
