package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.Room;
    import com.smartfoxserver.v2.entities.User;
    import com.smartfoxserver.v2.entities.data.ISFSObject;

    public class PublicMessageSFSEvent extends TypedSFSEvent
    {
        private var room:Room;
        private var sender:User;
        private var message:String;
        private var data:ISFSObject;

        public function PublicMessageSFSEvent(params:Object)
        {
            super(SFSEvent.PUBLIC_MESSAGE);

            this.room = params.room;
            this.sender = params.sender;
            this.message = params.message;
            this.data = params.data;
        }
    }
}
