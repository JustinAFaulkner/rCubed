package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class PrivateMessageSFSEvent extends TypedSFSEvent
    {
        public var message:String;
        public var userId:int;
        public var roomId:int;

        public function PrivateMessageSFSEvent(params:Object)
        {
            super(SFSEvent.onPrivateMessage);
            message = params.message;
            userId = params.userId;
            roomId = params.roomId;
        }
    }
}
