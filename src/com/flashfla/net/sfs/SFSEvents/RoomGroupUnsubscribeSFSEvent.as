package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import classes.Room
    import classes.User;

    public class RoomGroupUnsubscribeSFSEvent extends TypedSFSEvent
    {
        private var groupId:String;

        public function RoomGroupUnsubscribeSFSEvent(params:Object)
        {
            super(SFSEvent.ROOM_GROUP_UNSUBSCRIBE);

            groupId = params.groupId;
        }
    }
}
