package com.flashfla.net.events
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.flashfla.net.Multiplayer;

    public class LoginEvent extends TypedSFSEvent
    {
        public function LoginEvent()
        {
            super(Multiplayer.EVENT_LOGIN);
        }
    }
}
