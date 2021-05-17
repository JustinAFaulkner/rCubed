package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class ConnectionSFSEvent extends TypedSFSEvent
    {
        public var success:Boolean;
        public var error:String;

        public function ConnectionSFSEvent(params:Object)
        {
            super(SFSEvent.onConnection);
            success = params.success;
            error = params.error;
        }
    }
}
