package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class LogoutSFSEvent extends TypedSFSEvent
    {
        public function LogoutSFSEvent()
        {
            super(SFSEvent.LOGOUT);
        }
    }
}
