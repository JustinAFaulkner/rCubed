package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import classes.Room

    public class RoomVariablesUpdateSFSEvent extends TypedSFSEvent
    {
        public var room:Room;
        public var changedVars:Array;

        public function RoomVariablesUpdateSFSEvent(params:Object)
        {
            super(SFSEvent.onRoomVariablesUpdate);
            room = params.room;
            changedVars = params.changedVars;
        }
    }
}
