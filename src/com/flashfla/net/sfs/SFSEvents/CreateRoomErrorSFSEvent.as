package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class CreateRoomErrorSFSEvent extends TypedSFSEvent
    {
        public var error:String;

        public function CreateRoomErrorSFSEvent(params:Object)
        {
            super(SFSEvent.onCreateRoomError);
            error = params.error;
        }
    }
}
