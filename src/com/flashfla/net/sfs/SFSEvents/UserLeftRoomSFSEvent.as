package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class UserLeftRoomSFSEvent extends TypedSFSEvent
    {
        public var roomId:int;
        public var userId:int;

        public function UserLeftRoomSFSEvent(params:Object)
        {
            super(SFSEvent.onUserLeaveRoom);
            roomId = params.roomId;
            userId = params.userId;
        }
    }
}
