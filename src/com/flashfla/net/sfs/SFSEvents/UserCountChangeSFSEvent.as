package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class UserCountChangeSFSEvent extends TypedSFSEvent
    {
        public var roomId:int;
        public var userCount:int;
        public var specCount:int;

        public function UserCountChangeSFSEvent(params:Object)
        {
            super(SFSEvent.onUserCountChange);
            roomId = params.roomId;
            userCount = params.userCount;
            specCount = params.specCount;
        }
    }
}
