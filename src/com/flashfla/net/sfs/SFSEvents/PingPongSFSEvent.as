package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.User;
    import com.smartfoxserver.v2.entities.data.SFSObject;

    public class PingPongSFSEvent extends TypedSFSEvent
    {
        private var _lagValue:int;

        public function get lagValue():int
        {
            return _lagValue;
        }

        public function PingPongSFSEvent(params:Object)
        {
            super(SFSEvent.PING_PONG);

            this._lagValue = params.lagValue;
        }
    }
}
