package com.flashfla.net.events
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.flashfla.net.Multiplayer;

    public class RoomListEvent extends TypedSFSEvent
    {
        public function RoomListEvent()
        {
            super(Multiplayer.EVENT_ROOM_LIST);
        }
    }
}
