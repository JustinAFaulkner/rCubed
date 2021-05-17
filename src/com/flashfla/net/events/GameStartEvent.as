package com.flashfla.net.events
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import classes.Room
    import com.flashfla.net.Multiplayer;

    public class GameStartEvent extends TypedSFSEvent
    {
        public var room:Room;

        public function GameStartEvent(params:Object)
        {
            super(Multiplayer.EVENT_GAME_START);
            room = params.room;
        }
    }
}
