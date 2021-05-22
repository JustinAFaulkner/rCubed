package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.Room;

    public class RoomFindResultSFSEvent extends TypedSFSEvent
    {
        private var _room:Room;

        public function get room():Room
        {
            return _room;
        }

        public function RoomFindResultSFSEvent(params:Object)
        {
            super(SFSEvent.ROOM_FIND_RESULT);

            _room = params.room;
        }
    }
}
