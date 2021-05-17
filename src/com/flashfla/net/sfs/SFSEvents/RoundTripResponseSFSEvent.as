package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class RoundTripResponseSFSEvent extends TypedSFSEvent
    {
        public var elapsed:int;

        public function RoundTripResponseSFSEvent(params:Object)
        {
            super(SFSEvent.onRoundTripResponse);
            elapsed = params.elapsed;
        }
    }
}
