package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.Room;

    public class UserCountChangeSFSEvent extends TypedSFSEvent
    {
        private var room:Room;
        private var uCount:int;
        private var sCount:int;

        public function UserCountChangeSFSEvent(params:Object)
        {
            super(SFSEvent.USER_COUNT_CHANGE);

            this.room = params.room;
            this.uCount = params.uCount;
            this.sCount = params.sCount;
        }
    }
}
