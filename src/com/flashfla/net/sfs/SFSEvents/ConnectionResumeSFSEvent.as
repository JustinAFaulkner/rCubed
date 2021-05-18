package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class ConnectionResumeSFSEvent extends TypedSFSEvent
    {
        public function ConnectionResumeSFSEvent()
        {
            super(SFSEvent.CONNECTION_RESUME);
        }
    }
}
