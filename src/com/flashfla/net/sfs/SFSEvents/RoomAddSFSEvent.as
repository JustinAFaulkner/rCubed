package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.Room;

    public class RoomAddSFSEvent extends TypedSFSEvent
    {
        private var _room:Room;

        public function get room():Room
        {
            return _room;
        }

        public function RoomAddSFSEvent(params:Object)
        {
            super(SFSEvent.ROOM_ADD);

            _room = params.room;
        }
    }
}
