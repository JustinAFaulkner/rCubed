package com.flashfla.net.sfs.SFSEvents
{
    import com.flashfla.net.sfs.TypedSFSEvent;
    import com.smartfoxserver.v2.core.SFSEvent;

    public class CryptoInitSFSEvent extends TypedSFSEvent
    {
        public var success:Boolean;
        public var errorMessage:String;

        public function CryptoInitSFSEvent(params:Object)
        {
            super(SFSEvent.CRYPTO_INIT);

            this.success = params.success;
            this.errorMessage = params.errorMsg;
        }
    }
}
