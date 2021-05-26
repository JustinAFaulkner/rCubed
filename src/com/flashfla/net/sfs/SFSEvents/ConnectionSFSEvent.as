package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import flash.events.Event;

    public class ConnectionSFSEvent extends TypedSFSEvent
    {
        private var _success:Boolean;

        public function get success():Boolean
        {
            return _success;
        }

        public function ConnectionSFSEvent(success:Boolean)
        {
            super(SFSEvent.CONNECTION);

            this._success = success;
        }

        public override function clone():Event
        {
            return new ConnectionSFSEvent(this.success);
        }
    }
}
