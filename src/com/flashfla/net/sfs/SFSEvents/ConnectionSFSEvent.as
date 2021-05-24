package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import flash.events.Event;

    public class ConnectionSFSEvent extends TypedSFSEvent
    {
        public var success:Boolean;

        public function ConnectionSFSEvent(params:Object)
        {
            super(SFSEvent.CONNECTION);

            this.success = params.success;
        }

        public override function clone():Event
        {
            return new ConnectionSFSEvent({success: this.success});
        }
    }
}
