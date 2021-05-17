package com.flashfla.net.events
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.flashfla.net.Multiplayer;

    public class ConnectionEvent extends TypedSFSEvent
    {

        public function ConnectionEvent()
        {
            super(Multiplayer.EVENT_CONNECTION);
        }
    }
}
