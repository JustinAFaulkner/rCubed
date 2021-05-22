package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.User;
    import com.smartfoxserver.v2.entities.data.ISFSObject;

    public class ModeratorMessageSFSEvent extends TypedSFSEvent
    {
        private var _sender:User;
        private var _message:String;
        private var _data:ISFSObject;

        public function get sender():User
        {
            return _sender;
        }

        public function get message():String
        {
            return _message;
        }


        public function get data():ISFSObject
        {
            return _data;
        }

        public function ModeratorMessageSFSEvent(params:Object)
        {
            super(SFSEvent.MODERATOR_MESSAGE);

            this._sender = params.sender;
            this._message = params.message;
            this._data = params.data;
        }
    }
}
