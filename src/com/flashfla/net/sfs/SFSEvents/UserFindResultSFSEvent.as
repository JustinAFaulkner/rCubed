package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class UserFindResultSFSEvent extends TypedSFSEvent
    {
        private var _users:Array;

        public function UserFindResultSFSEvent(params:Object)
        {
            super(SFSEvent.USER_FIND_RESULT);

            _users = params.users;
        }
    }
}
