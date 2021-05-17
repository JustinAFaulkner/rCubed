package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class LeftRoomSFSEvent extends TypedSFSEvent
    {
        public var roomId:int;

        public function LeftRoomSFSEvent(params:Object)
        {
            super(SFSEvent.onRoomLeft);
            roomId = params.roomId;
        }
    }
}
