package com.flashfla.net
{
    import classes.User;
    import com.smartfoxserver.v2.entities.User;
    import flash.events.EventDispatcher;

    public class MultiplayerUser extends EventDispatcher
    {
        private var sfsUser:com.smartfoxserver.v2.entities.User;
        private var ffrUser:classes.User;

        public function MultiplayerUser(ffrUser:classes.User, sfsUser:com.smartfoxserver.v2.entities.User)
        {
            this.sfsUser = sfsUser;
            this.ffrUser = ffrUser;
        }

        public function get name():String
        {
            return ffrUser.name;
        }

        public function get id():int
        {
            return ffrUser.id;
        }

        public function isAdmin():Boolean
        {
            return sfsUser.isAdmin;
        }

        public function isPlayer():Boolean
        {
            return sfsUser.isPlayer;
        }

        public function isModerator():Boolean
        {
            return sfsUser.isModerator;
        }

        public function isSpectator():Boolean
        {
            return sfsUser.isSpectator;
        }

        public function isStandardUser():Boolean
        {
            return sfsUser.isStandardUser();
        }

        public function isItMe():Boolean
        {
            return sfsUser.isItMe;
        }
    }
}
