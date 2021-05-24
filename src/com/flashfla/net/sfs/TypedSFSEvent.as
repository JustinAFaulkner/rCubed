package com.flashfla.net.sfs
{
    import flash.events.Event;

    public class TypedSFSEvent extends Event
    {
        private const BUBBLES:Boolean = true;
        private const CANCELLABLE:Boolean = false;

        public function TypedSFSEvent(type:String)
        {
            super(type, BUBBLES, CANCELLABLE);
        }

        public override function clone():Event
        {
            return new TypedSFSEvent(type);
        }
    }
}
