package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class LoginSFSEvent extends TypedSFSEvent
    {
        public var success:Boolean;
        public var name:String;
        public var error:String;

        public function LoginSFSEvent(params:Object)
        {
            super(SFSEvent.onLogin);
            success = params.success;
            name = params.name;
            error = params.error;
        }
    }
}
