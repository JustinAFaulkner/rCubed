package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.User;
    import com.smartfoxserver.v2.entities.data.SFSObject;

    public class ObjectMessageSFSEvent extends TypedSFSEvent
    {
        private var _sender:User;
        private var _message:SFSObject;

        public function get sender():User
        {
            return _sender;
        }

        public function get message():SFSObject
        {
            return _message;
        }

        public function ObjectMessageSFSEvent(params:Object)
        {
            super(SFSEvent.OBJECT_MESSAGE);

            this._sender = params.sender;
            this._message = params.message;
        }
    }
}
