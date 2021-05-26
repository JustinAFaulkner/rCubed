package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.User;
    import com.smartfoxserver.v2.entities.data.ISFSObject;
    import flash.events.Event;

    public class LoginSFSEvent extends TypedSFSEvent
    {
        private var _user:User;
        private var _data:ISFSObject;

        public function get user():User
        {
            return _user;
        }

        public function get data():ISFSObject
        {
            return _data;
        }

        public function LoginSFSEvent(user:User, data:ISFSObject)
        {
            super(SFSEvent.LOGIN);

            this._user = user;
            this._data = data;
        }

        public override function clone():Event
        {
            return new LoginSFSEvent(this._user, this._data);
        }
    }
}
