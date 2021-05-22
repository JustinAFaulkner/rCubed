package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.Room;

    public class RoomRemoveSFSEvent extends TypedSFSEvent
    {
        private var _room:Room;

        public function get room():Room
        {
            return _room;
        }

        public function RoomRemoveSFSEvent(params:Object)
        {
            super(SFSEvent.ROOM_REMOVE);

            _room = params.room;
        }
    }
}
