package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class UDPInitSFSEvent extends TypedSFSEvent
    {
        private var _success:Boolean;

        public function get success():Boolean
        {
            return _success;
        }

        public function UDPInitSFSEvent(params:Object)
        {
            super(SFSEvent.UDP_INIT);

            this._success = params.success;
        }
    }
}
