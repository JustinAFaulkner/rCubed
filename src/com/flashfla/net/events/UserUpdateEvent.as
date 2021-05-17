package com.flashfla.net.events
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.flashfla.net.Multiplayer;
    import classes.User;

    public class UserUpdateEvent extends TypedSFSEvent
    {
        public var user:User;

        public function UserUpdateEvent(params:Object)
        {
            super(Multiplayer.EVENT_USER_UPDATE);
            user = params.user;
        }
    }
}
