package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.Room;
    import com.smartfoxserver.v2.entities.User;

    public class SpectatorToPlayerSFSEvent extends TypedSFSEvent
    {
        private var _room:Room;
        private var _users:User;
        private var _playerId:int;

        public function get room():Room
        {
            return _room;
        }

        private function get users():User
        {
            return _users;
        }

        private function get playerId():int
        {
            return _playerId;
        }

        public function SpectatorToPlayerSFSEvent(params:Object)
        {
            super(SFSEvent.ROOM_NAME_CHANGE);

            _room = params.room;
            _users = params.users;
            _playerId = params.playerId;
        }
    }
}
