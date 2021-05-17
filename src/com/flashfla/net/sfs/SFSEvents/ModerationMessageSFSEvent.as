package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class ModerationMessageSFSEvent extends TypedSFSEvent
    {
        public var message:String;
        public var roomId:int;
        public var userId:int;

        public function ModerationMessageSFSEvent(params:Object)
        {
            super(SFSEvent.onModeratorMessage);
            message = params.message;
            roomId = params.roomId;
            userId = params.userId;
        }
    }
}
