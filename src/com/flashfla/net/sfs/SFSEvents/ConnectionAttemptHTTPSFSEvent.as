package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class ConnectionAttemptHTTPSFSEvent extends TypedSFSEvent
    {
        public function ConnectionAttemptHTTPSFSEvent()
        {
            super(SFSEvent.CONNECTION_ATTEMPT_HTTP);
        }
    }
}
