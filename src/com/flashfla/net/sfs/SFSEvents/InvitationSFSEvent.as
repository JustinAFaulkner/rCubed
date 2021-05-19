package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.invitation.Invitation;

    public class InvitationSFSEvent extends TypedSFSEvent
    {
        public var invitation:Invitation;

        public function InvitationSFSEvent(params:Object)
        {
            super(SFSEvent.INVITATION);

            this.invitation = params.invitation;
        }
    }
}
