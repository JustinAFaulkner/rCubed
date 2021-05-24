package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.Room;
    import com.smartfoxserver.v2.entities.User;
    import com.smartfoxserver.v2.entities.data.ISFSObject;

    public class PublicMessageSFSEvent extends TypedSFSEvent
    {
        private var _room:Room;

        public function get room():Room
        {
            return _room;
        }

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

        public function PublicMessageSFSEvent(params:Object)
        {
            super(SFSEvent.PUBLIC_MESSAGE);

            this._room = params.room;
            this._sender = params.sender;
            this._message = params.message;
            this._data = params.data;
        }
    }
}
