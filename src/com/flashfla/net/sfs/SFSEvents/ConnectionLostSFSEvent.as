package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.util.ClientDisconnectionReason;

    public class ConnectionLostSFSEvent extends TypedSFSEvent
    {
        public var reason:String;

        public function ConnectionLostSFSEvent(params:Object)
        {
            super(SFSEvent.CONNECTION_LOST);

            this.reason = params.reason;
        }

        public function WasIdle():Boolean
        {
            return this.reason == ClientDisconnectionReason.IDLE;
        }

        public function WasKicked():Boolean
        {
            return this.reason == ClientDisconnectionReason.KICK;
        }

        public function WasBanned():Boolean
        {
            return this.reason == ClientDisconnectionReason.BAN;
        }
    }
}
