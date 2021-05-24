package com.flashfla.net.events
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.flashfla.net.Multiplayer;

    public class ErrorEvent extends TypedSFSEvent
    {
        private var _message:String;

        public function get message():String
        {
            return _message;
        }

        public function ErrorEvent(message:String)
        {
            super(Multiplayer.EVENT_ERROR);

            this._message = message;
        }
    }
}
