package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.User;
    import com.smartfoxserver.v2.entities.data.ISFSObject;

    public class LoginErrorSFSEvent extends TypedSFSEvent
    {
        private var errorMessage:String;
        private var errorCode:int;

        public function LoginErrorSFSEvent(params:Object)
        {
            super(SFSEvent.LOGIN_ERROR);

            this.errorMessage = params.errorMessage;
            this.errorCode = params.errorCode;
        }
    }
}
