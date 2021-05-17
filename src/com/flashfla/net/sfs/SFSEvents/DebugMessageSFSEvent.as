package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class DebugMessageSFSEvent extends TypedSFSEvent
    {
        public var message:String;

        public function DebugMessageSFSEvent(params:Object)
        {
            super(SFSEvent.onDebugMessage);
            message = params.message;
        }
    }
}
