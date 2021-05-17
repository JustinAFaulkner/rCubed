package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class PublicMessageSFSEvent extends TypedSFSEvent
    {
        public var message:String;
        public var userId:int;
        public var roomId:int;

        public function PublicMessageSFSEvent(params:Object)
        {
            super(SFSEvent.onPublicMessage);
            message = params.message;
            userId = params.userId;
            roomId = params.roomId;
        }
    }
}
