package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.data.ISFSObject;
    import com.smartfoxserver.v2.entities.User;

    public class AdminMessageSFSEvent extends TypedSFSEvent
    {
        private var _sender:User;

        public function get sender():User
        {
            return _sender;
        }

        private var _message:String;

        public function get message():String
        {
            return _message;
        }

        private var _data:ISFSObject;

        public function get data():ISFSObject
        {
            return _data;
        }

        public function AdminMessageSFSEvent(sender:User, message:String, data:ISFSObject)
        {
            super(SFSEvent.ADMIN_MESSAGE);

            this._sender = sender;
            this._message = message;
            this._data = data;
        }
    }
}
