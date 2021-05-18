package com.flashfla.net.sfs.SFSEvents
{

    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;
    import com.smartfoxserver.v2.entities.data.*;
    import classes.Room;

    public class ExtensionResponseSFSEvent extends TypedSFSEvent
    {
        public var command:String;
        public var params:ISFSObject;
        public var room:Room;
        public var packetId:Number;

        public function ExtensionResponseSFSEvent(params:Object)
        {
            super(SFSEvent.EXTENSION_RESPONSE);

            this.command = params.command;
            this.params = params.params as SFSObject;

            // TODO: Construct classes.Room from SFSRoom.
            //this.room

            this.packetId = params.packetId;
        }
    }
}
