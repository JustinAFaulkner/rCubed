package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class SocketErrorSFSEvent extends TypedSFSEvent
    {
        private var _errorMessage:String;

        public function get errorMessage():String
        {
            return _errorMessage;
        }

        public function SocketErrorSFSEvent(params:Object)
        {
            super(SFSEvent.SOCKET_ERROR);

            this._errorMessage = params.error;
        }
    }
}
