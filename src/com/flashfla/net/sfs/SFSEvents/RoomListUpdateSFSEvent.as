package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import classes.Room

    public class RoomListUpdateSFSEvent extends TypedSFSEvent
    {
        public var roomList:Vector.<Room>;

        public function RoomListUpdateSFSEvent(params:Object)
        {
            super(SFSEvent.onRoomListUpdate);
            roomList = params.roomList;
        }
    }
}
