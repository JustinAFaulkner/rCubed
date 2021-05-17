package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import classes.User;

    public class UserVariablesUpdateSFSEvent extends TypedSFSEvent
    {
        public var user:User;
        public var changedVars:Array;

        public function UserVariablesUpdateSFSEvent(params:Object)
        {
            super(SFSEvent.onUserVariablesUpdate);
            user = params.user;
            changedVars = params.changedVars;
        }
    }
}
