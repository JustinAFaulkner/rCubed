package com.flashfla.net.events
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import classes.Room
    import com.flashfla.net.Multiplayer;

    public class RoomUpdateEvent extends TypedSFSEvent
    {
        public var room:Room;
        public var roomList:Boolean;

        public function RoomUpdateEvent(params:Object)
        {
            super(Multiplayer.EVENT_ROOM_UPDATE);
            room = params.room;
            roomList = params.roomList;
        }
    }
}
