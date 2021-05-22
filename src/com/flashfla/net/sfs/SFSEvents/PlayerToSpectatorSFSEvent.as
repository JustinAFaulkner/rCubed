package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import classes.Room
    import classes.User;

    public class PlayerToSpectatorSFSEvent extends TypedSFSEvent
    {
        private var _room:Room;
        private var _users:User;

        public function get room():Room
        {
            return _room;
        }

        public function get users():User
        {
            return _users;
        }

        public function PlayerToSpectatorSFSEvent(params:Object)
        {
            super(SFSEvent.PLAYER_TO_SPECTATOR);

            _room = params.room;
            _users = params.users
        }
    }
}
