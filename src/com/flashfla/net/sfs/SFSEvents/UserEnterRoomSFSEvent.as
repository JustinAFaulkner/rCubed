package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import classes.User;

    public class UserEnterRoomSFSEvent extends TypedSFSEvent
    {
        public var roomId:int;
        public var user:User;

        public function UserEnterRoomSFSEvent(params:Object)
        {
            super(SFSEvent.onUserEnterRoom);
            roomId = params.roomId;
            user = params.user;
        }
    }
}
