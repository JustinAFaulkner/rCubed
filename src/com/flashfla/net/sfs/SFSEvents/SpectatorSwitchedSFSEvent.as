package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class SpectatorSwitchedSFSEvent extends TypedSFSEvent
    {
        public var playerId:int;
        public var userId:int;
        public var roomId:int;

        public function SpectatorSwitchedSFSEvent(params:Object)
        {
            super(SFSEvent.onSpectatorSwitched);
            playerId = params.playerId;
            userId = params.userId;
            roomId = params.roomId;
        }
    }
}
