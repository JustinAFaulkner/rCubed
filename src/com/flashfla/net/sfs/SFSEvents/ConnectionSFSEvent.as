package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.flashfla.net.Multiplayer;

    public class ConnectionSFSEvent extends TypedSFSEvent
    {
        public var success:Boolean;

        public function ConnectionSFSEvent(params:Object)
        {
            super(Multiplayer.EVENT_CONNECTION);

            this.success = params.success;
        }
    }
}
