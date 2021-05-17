package com.flashfla.net.events
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.flashfla.net.Multiplayer;

    public class ErrorEvent extends TypedSFSEvent
    {
        public var message:String;

        public function ErrorEvent(params:Object)
        {
            super(Multiplayer.EVENT_ERROR);
            message = params.message;
        }
    }
}
