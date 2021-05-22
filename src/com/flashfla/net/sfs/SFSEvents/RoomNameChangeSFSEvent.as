package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.Room;

    public class RoomNameChangeSFSEvent extends TypedSFSEvent
    {
        private var _room:Room;
        private var _oldName:String;

        private function get oldName():String
        {
            return _oldName;
        }

        public function get room():Room
        {
            return _room;
        }

        public function RoomNameChangeSFSEvent(params:Object)
        {
            super(SFSEvent.ROOM_NAME_CHANGE);

            _room = params.room;
            _oldName = params.oldName;
        }
    }
}
