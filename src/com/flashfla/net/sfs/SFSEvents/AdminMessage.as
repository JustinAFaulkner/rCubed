package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.data.ISFSObject;
    import classes.User;

    public class AdminMessage extends TypedSFSEvent
    {
        public var sender:User;
        public var message:String;
        public var data:ISFSObject;

        public function AdminMessage(params:Object)
        {
            super(SFSEvent.ADMIN_MESSAGE);

            sender = params.sender;
            message = params.message;
            data = params.data;
        }
    }
}
