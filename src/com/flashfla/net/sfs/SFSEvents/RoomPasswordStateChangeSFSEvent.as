package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.Room;

    public class RoomPasswordStateChangeSFSEvent extends TypedSFSEvent
    {
        private var _room:Room;

        public function get room():Room
        {
            return _room;
        }

        public function RoomPasswordStateChangeSFSEvent(params:Object)
        {
            super(SFSEvent.ROOM_PASSWORD_STATE_CHANGE);

            _room = params.room;
        }
    }
}
