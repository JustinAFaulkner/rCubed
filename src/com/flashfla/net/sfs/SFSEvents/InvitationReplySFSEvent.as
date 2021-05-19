package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.User;
    import com.smartfoxserver.v2.entities.data.ISFSObject;
    import flash.html.__HTMLScriptArray;
    import com.smartfoxserver.v2.entities.invitation.InvitationReply;

    public class InvitationReplySFSEvent extends TypedSFSEvent
    {
        public var invitee:User;
        public var reply:int;
        public var data:ISFSObject;

        public function InvitationReplySFSEvent(params:Object)
        {
            super(SFSEvent.INVITATION_REPLY);

            this.invitee = params.invitee;
            this.reply = params.reply;
            this.data = params.data;
        }

        public function IsAccepted():Boolean
        {
            return this.reply == InvitationReply.ACCEPT;
        }

        public function IsExpired():Boolean
        {
            return this.reply == InvitationReply.EXPIRED;
        }

        public function IsRefused():Boolean
        {
            return this.reply == InvitationReply.REFUSE;
        }
    }
}
