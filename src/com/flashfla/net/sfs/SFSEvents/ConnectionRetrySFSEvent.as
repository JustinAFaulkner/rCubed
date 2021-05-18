package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class ConnectionRetrySFSEvent extends TypedSFSEvent
    {
        public function ConnectionRetrySFSEvent()
        {
            super(SFSEvent.CONNECTION_RETRY);
        }
    }
}
