package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.Room;

    public class RoomGroupSubscribeSFSEvent extends TypedSFSEvent
    {
        private var groupId:String;
        private var newRooms:Vector.<Room>;

        public function RoomGroupSubscribeSFSEvent(params:Object)
        {
            super(SFSEvent.ROOM_GROUP_SUBSCRIBE);

            groupId = params.groupId;

            // TODO: Convert this from a generic "Array" to a Vector of Rooms.
            newRooms = params.newRooms
        }
    }
}
