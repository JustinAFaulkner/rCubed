package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class RoomDeletedSFSEvent extends TypedSFSEvent
    {
        public var roomId:int;

        public function RoomDeletedSFSEvent(params:Object)
        {
            super(SFSEvent.onRoomDeleted);
            roomId = params.roomId;
        }
    }
}
