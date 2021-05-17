package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class ConfigLoadFailureSFSEvent extends TypedSFSEvent
    {
        public var message:String;

        public function ConfigLoadFailureSFSEvent(params:Object)
        {
            super(SFSEvent.onConfigLoadFailure);
            message = params.message;
        }
    }
}
