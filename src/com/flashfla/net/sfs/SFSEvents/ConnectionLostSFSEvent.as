package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class ConnectionLostSFSEvent extends TypedSFSEvent
    {

        public function ConnectionLostSFSEvent()
        {
            super(SFSEvent.onConnectionLost);
        }
    }
}
