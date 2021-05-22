package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.Room;

    public class RoomVariablesUpdateSFSEvent extends TypedSFSEvent
    {
        private var _room:Room;
        private var changedVars:Array;

        public function get room():Room
        {
            return _room;
        }

        public function RoomVariablesUpdateSFSEvent(params:Object)
        {
            super(SFSEvent.ROOM_VARIABLES_UPDATE);

            _room = params.room;
            changedVars = params.changedVars;
        }
    }
}
