package com.flashfla.net.events
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import classes.Room
    import com.flashfla.net.Multiplayer;

    public class GameResultsEvent extends TypedSFSEvent
    {
        public var room:Room;

        public function GameResultsEvent(params:Object)
        {
            super(Multiplayer.EVENT_GAME_RESULTS);
            room = params.room;
        }
    }
}
