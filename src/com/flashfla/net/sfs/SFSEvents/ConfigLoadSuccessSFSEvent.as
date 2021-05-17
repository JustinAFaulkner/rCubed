package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class ConfigLoadSuccessSFSEvent extends TypedSFSEvent
    {

        public function ConfigLoadSuccessSFSEvent()
        {
            super(SFSEvent.onConfigLoadSuccess);
        }
    }
}
