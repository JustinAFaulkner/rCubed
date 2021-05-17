package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class JoinRoomErrorSFSEvent extends TypedSFSEvent
    {
        public var error:String;

        public function JoinRoomErrorSFSEvent(params:Object)
        {
            super(SFSEvent.onJoinRoomError);
            error = params.error;
        }
    }
}
