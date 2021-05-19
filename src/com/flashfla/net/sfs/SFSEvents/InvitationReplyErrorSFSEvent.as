package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class InvitationReplyErrorSFSEvent extends TypedSFSEvent
    {
        public var error:String;
        public var errorCode:int;

        public function InvitationReplyErrorSFSEvent(params:Object)
        {
            super(SFSEvent.INVITATION_REPLY_ERROR);

            this.error = params.error;
            this.errorCode = params.errorCode;
        }
    }
}
