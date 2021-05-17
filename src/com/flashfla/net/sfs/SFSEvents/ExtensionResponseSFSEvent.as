package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class ExtensionResponseSFSEvent extends TypedSFSEvent
    {
        public var dataObj:Object;
        public var protocol:String;

        public function ExtensionResponseSFSEvent(params:Object)
        {
            super(SFSEvent.onExtensionResponse);
            dataObj = params.dataObj;
            protocol = params.protocol;
        }
    }
}
