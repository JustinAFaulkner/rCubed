package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.User;
    import com.smartfoxserver.v2.entities.data.ISFSObject;

    public class LoginErrorSFSEvent extends TypedSFSEvent
    {
        private var _errorMessage:String;

        public function get errorMessage():String
        {
            return _errorMessage;
        }

        public var _errorCode:int;

        private function get errorCode():int
        {
            return _errorCode;
        }

        public function LoginErrorSFSEvent(params:Object)
        {
            super(SFSEvent.LOGIN_ERROR);

            this._errorMessage = params.errorMessage;
            this._errorCode = params.errorCode;
        }
    }
}
