package com.flashfla.net
{
    import com.flashfla.net.sfs.SFSEvents.*;
    import com.smartfoxserver.v2.SmartFox;
    import com.smartfoxserver.v2.core.SFSEvent;
    import classes.User;

    public class SFS2XEventHandler
    {
        private var sfs:SmartFox;

        // TODO: For the API for each implementation, see here:
        // TODO: http://docs2x.smartfoxserver.com/api-docs/asdoc/com/smartfoxserver/v2/core/SFSEvent.html

        public function SFS2XEventHandler(sfs:SmartFox)
        {
            this.sfs = sfs;

            this.sfs.addEventListener(SFSEvent.ADMIN_MESSAGE, handleAdminMessage);
            this.sfs.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, handleConfigLoadFailure);
            this.sfs.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, handleConfigLoadSuccess);
            this.sfs.addEventListener(SFSEvent.CONNECTION, handleConnection);
            this.sfs.addEventListener(SFSEvent.CONNECTION_ATTEMPT_HTTP, handleConnectionAttemptHttp);
            this.sfs.addEventListener(SFSEvent.CONNECTION_LOST, handleConnectionLost);
            this.sfs.addEventListener(SFSEvent.CONNECTION_RESUME, handleConnectionResume);
            this.sfs.addEventListener(SFSEvent.CONNECTION_RETRY, handleConnectionRetry);
            this.sfs.addEventListener(SFSEvent.CRYPTO_INIT, handleCryptoInit);
            this.sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, handleExtensionResponse);
            this.sfs.addEventListener(SFSEvent.HANDSHAKE, handleHandleshake);
            this.sfs.addEventListener(SFSEvent.INVITATION, handleInvitation);
            this.sfs.addEventListener(SFSEvent.INVITATION_REPLY, handleInvitationReply);
            this.sfs.addEventListener(SFSEvent.INVITATION_REPLY_ERROR, handleInvitationReplyError);
            this.sfs.addEventListener(SFSEvent.LOGIN, handleLogin);
            this.sfs.addEventListener(SFSEvent.LOGIN_ERROR, handleLoginError);
            this.sfs.addEventListener(SFSEvent.LOGOUT, handleLogout);
            this.sfs.addEventListener(SFSEvent.MMOITEM_VARIABLES_UPDATE, handleMMOItemVariablesUpdate);
            this.sfs.addEventListener(SFSEvent.MODERATOR_MESSAGE, handleModeratorMessage);
            this.sfs.addEventListener(SFSEvent.OBJECT_MESSAGE, handleObjectMessage);
            this.sfs.addEventListener(SFSEvent.PING_PONG, handlePingPong);
            this.sfs.addEventListener(SFSEvent.PLAYER_TO_SPECTATOR, handlePlayerToSpectator);
            this.sfs.addEventListener(SFSEvent.PLAYER_TO_SPECTATOR_ERROR, handlePlayerToSpectatorError);
            this.sfs.addEventListener(SFSEvent.PRIVATE_MESSAGE, handlePrivateMessage);
            this.sfs.addEventListener(SFSEvent.PROXIMITY_LIST_UPDATE, handleProximityListUpdate);
            this.sfs.addEventListener(SFSEvent.PUBLIC_MESSAGE, handlePublicMessage);
            this.sfs.addEventListener(SFSEvent.ROOM_ADD, handleRoomAdd);
            this.sfs.addEventListener(SFSEvent.ROOM_CAPACITY_CHANGE, handleRoomCapacityChange);
            this.sfs.addEventListener(SFSEvent.ROOM_CAPACITY_CHANGE_ERROR, handleRoomCapacityChangeError);
            this.sfs.addEventListener(SFSEvent.ROOM_CREATION_ERROR, handleRoomCreationError);
            this.sfs.addEventListener(SFSEvent.ROOM_FIND_RESULT, handleRoomFindResult);
            this.sfs.addEventListener(SFSEvent.ROOM_GROUP_SUBSCRIBE, handleRoomGroupSubscribe);
            this.sfs.addEventListener(SFSEvent.ROOM_GROUP_SUBSCRIBE_ERROR, handleRoomGroupSubscribeError);
            this.sfs.addEventListener(SFSEvent.ROOM_GROUP_UNSUBSCRIBE, handleRoomGroupUnsubscribe);
            this.sfs.addEventListener(SFSEvent.ROOM_GROUP_UNSUBSCRIBE_ERROR, handleRoomGroupUnsubscribeError);
            this.sfs.addEventListener(SFSEvent.ROOM_JOIN, handleRoomJoin);
            this.sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, handleRoomJoinError);
            this.sfs.addEventListener(SFSEvent.ROOM_NAME_CHANGE, handleRoomNameChange);
            this.sfs.addEventListener(SFSEvent.ROOM_NAME_CHANGE_ERROR, handleRoomChangeError);
            this.sfs.addEventListener(SFSEvent.ROOM_PASSWORD_STATE_CHANGE, handleRoomPasswordStateChange);
            this.sfs.addEventListener(SFSEvent.ROOM_PASSWORD_STATE_CHANGE_ERROR, handleRoomPasswordStateChangeError);
            this.sfs.addEventListener(SFSEvent.ROOM_REMOVE, handleRoomRemove);
            this.sfs.addEventListener(SFSEvent.ROOM_VARIABLES_UPDATE, handleRoomVariablesUpdate);
            this.sfs.addEventListener(SFSEvent.SOCKET_ERROR, handleSocketError);
            this.sfs.addEventListener(SFSEvent.SPECTATOR_TO_PLAYER, handleSpectatorToPlayer);
            this.sfs.addEventListener(SFSEvent.SPECTATOR_TO_PLAYER_ERROR, handleSpectatorToPlayerError);
            this.sfs.addEventListener(SFSEvent.UDP_INIT, handleUdpInit);
            this.sfs.addEventListener(SFSEvent.USER_COUNT_CHANGE, handleUserCountChange);
            this.sfs.addEventListener(SFSEvent.USER_ENTER_ROOM, handleUserEnterRoom);
            this.sfs.addEventListener(SFSEvent.USER_EXIT_ROOM, handleUserExitRoom);
            this.sfs.addEventListener(SFSEvent.USER_FIND_RESULT, handleUserFindResult);
            this.sfs.addEventListener(SFSEvent.USER_VARIABLES_UPDATE, handleUserVAriablesUpdate);
        }

        private function handleAdminMessage(event:SFSEvent):void
        {
            // TODO: This seems unnecessarily heavy.
            var newUser:User = new User();
            newUser.id = event.params.user.id
            newUser.name = event.params.user.name;

            new AdminMessage({sender: newUser, message: event.params.message, data: event.params.data});
        }

        private function handleConfigLoadFailure(event:SFSEvent):void
        {
        }

        private function handleConfigLoadSuccess(event:SFSEvent):void
        {
        }

        private function handleConnection(event:SFSEvent):void
        {
        }

        private function handleConnectionAttemptHttp(event:SFSEvent):void
        {
        }

        private function handleConnectionLost(event:SFSEvent):void
        {
        }

        private function handleConnectionResume(event:SFSEvent):void
        {
        }

        private function handleConnectionRetry(event:SFSEvent):void
        {
        }

        private function handleCryptoInit(event:SFSEvent):void
        {
        }

        private function handleExtensionResponse(event:SFSEvent):void
        {
        }

        private function handleHandleshake(event:Object):void
        {
        }

        private function handleInvitation(event:SFSEvent):void
        {
        }

        private function handleInvitationReply(event:SFSEvent):void
        {
        }

        private function handleInvitationReplyError(event:SFSEvent):void
        {
        }

        private function handleLogin(event:SFSEvent):void
        {
        }

        private function handleLoginError(event:SFSEvent):void
        {
        }

        private function handleLogout(event:SFSEvent):void
        {
        }

        private function handleMMOItemVariablesUpdate(event:SFSEvent):void
        {
        }

        private function handleModeratorMessage(event:SFSEvent):void
        {
        }

        private function handleObjectMessage(event:SFSEvent):void
        {
        }

        private function handlePingPong(event:SFSEvent):void
        {
        }

        private function handlePlayerToSpectator(event:SFSEvent):void
        {
        }

        private function handlePlayerToSpectatorError(event:SFSEvent):void
        {
        }

        private function handlePrivateMessage(event:SFSEvent):void
        {
        }

        private function handleProximityListUpdate(event:SFSEvent):void
        {
        }

        private function handlePublicMessage(event:SFSEvent):void
        {
        }

        private function handleRoomAdd(event:SFSEvent):void
        {
        }

        private function handleRoomCapacityChange(event:SFSEvent):void
        {
        }

        private function handleRoomCapacityChangeError(event:SFSEvent):void
        {
        }

        private function handleRoomCreationError(event:SFSEvent):void
        {
        }

        private function handleRoomFindResult(event:SFSEvent):void
        {
        }

        private function handleRoomGroupSubscribe(event:SFSEvent):void
        {
        }

        private function handleRoomGroupSubscribeError(event:SFSEvent):void
        {
        }

        private function handleRoomGroupUnsubscribe(event:SFSEvent):void
        {
        }

        private function handleRoomGroupUnsubscribeError(event:SFSEvent):void
        {
        }

        private function handleRoomJoin(event:SFSEvent):void
        {
        }

        private function handleRoomJoinError(event:SFSEvent):void
        {
        }

        private function handleRoomNameChange(event:SFSEvent):void
        {
        }

        private function handleRoomChangeError(event:SFSEvent):void
        {
        }

        private function handleRoomPasswordStateChange(event:SFSEvent):void
        {
        }

        private function handleRoomPasswordStateChangeError(event:SFSEvent):void
        {
        }

        private function handleRoomRemove(event:SFSEvent):void
        {
        }

        private function handleRoomVariablesUpdate(event:SFSEvent):void
        {
        }

        private function handleSocketError(event:SFSEvent):void
        {
        }

        private function handleSpectatorToPlayer(event:SFSEvent):void
        {
        }

        private function handleSpectatorToPlayerError(event:SFSEvent):void
        {
        }

        private function handleUdpInit(event:SFSEvent):void
        {
        }

        private function handleUserCountChange(event:SFSEvent):void
        {
        }

        private function handleUserEnterRoom(event:SFSEvent):void
        {
        }

        private function handleUserExitRoom(event:SFSEvent):void
        {
        }

        private function handleUserFindResult(event:SFSEvent):void
        {
        }

        private function handleUserVAriablesUpdate(event:SFSEvent):void
        {
        }
    }
}
