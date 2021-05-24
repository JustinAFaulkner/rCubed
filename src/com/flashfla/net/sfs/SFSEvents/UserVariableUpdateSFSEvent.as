package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.Room;
    import com.smartfoxserver.v2.entities.User;

    public class UserVariableUpdateSFSEvent extends TypedSFSEvent
    {
        private var user:User;
        private var changedVars:Array;

        public function UserVariableUpdateSFSEvent(params:Object)
        {
            super(SFSEvent.USER_VARIABLES_UPDATE);

            user = params.user;
            changedVars = params.changedVars;
        }
    }
}
