package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.data.ISFSObject;
    import com.smartfoxserver.v2.entities.User;

    public class PrivateMessageSFSEvent extends TypedSFSEvent
    {
        private var sender:User;
        private var message:String;
        private var data:ISFSObject;

        public function PrivateMessageSFSEvent(params:Object)
        {
            super(SFSEvent.PRIVATE_MESSAGE);

            this.sender = params.sender;
            this.message = params.message;
            this.data = params.data;
        }
    }
}
