package com.flashfla.net
{
    import com.flashfla.net.sfs.SFSEvents.*;
    import com.smartfoxserver.v2.SmartFox;
    import com.smartfoxserver.v2.core.SFSEvent;
    import classes.User;
    import flash.events.EventDispatcher;
    import com.flashfla.net.sfs.SFSEvents.ConfigLoadSuccessSFSEvent;
    import com.flashfla.net.sfs.SFSEvents.CryptoInitSFSEvent;
    import com.flashfla.net.sfs.SFSEvents.ExtensionResponseSFSEvent;
    import classes.Room;
    import com.smartfoxserver.v2.entities.SFSRoom;
    import com.smartfoxserver.v2.entities.invitation.InvitationReply;
    import com.flashfla.net.sfs.SFSEvents.InvitationReplySFSEvent;
    import com.flashfla.net.sfs.SFSEvents.LoginSFSEvent;

    public class SFS2XEventHandler extends EventDispatcher
    {
        private var sfs:SmartFox;

        private const USE_CAPTURE:Boolean = true;
        private const PRIORITY_VALUE:int = int.MAX_VALUE - 10;

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
            this.sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, handleExtensionResponse, USE_CAPTURE, PRIORITY_VALUE);
            //this.sfs.addEventListener(SFSEvent.HANDSHAKE, handleHandleshake); // This event is missing from the API docs.
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
            this.dispatchEvent(new AdminMessageSFSEvent({sender: newUser, message: event.params.message, data: event.params.data}));
        }

        private function handleConfigLoadFailure(event:SFSEvent):void
        {
            this.dispatchEvent(new ConfigLoadFailureSFSEvent());
        }

        private function handleConfigLoadSuccess(event:SFSEvent):void
        {
            this.dispatchEvent(new ConfigLoadSuccessSFSEvent());
        }

        private function handleConnection(event:SFSEvent):void
        {
            this.dispatchEvent(new ConnectionSFSEvent(event.params))
        }

        private function handleConnectionAttemptHttp(event:SFSEvent):void
        {
            this.dispatchEvent(new ConnectionAttemptHTTPSFSEvent())
        }

        private function handleConnectionLost(event:SFSEvent):void
        {
            this.dispatchEvent(new ConnectionLostSFSEvent(event.params))
        }

        private function handleConnectionResume(event:SFSEvent):void
        {
            this.dispatchEvent(new ConnectionResumeSFSEvent());
        }

        private function handleConnectionRetry(event:SFSEvent):void
        {
            this.dispatchEvent(new ConnectionRetrySFSEvent());
        }

        private function handleCryptoInit(event:SFSEvent):void
        {
            this.dispatchEvent(new CryptoInitSFSEvent(event.params));
        }

        private function handleExtensionResponse(event:SFSEvent):void
        {
            var sfsRoom:SFSRoom = event.params.room;
            var room:Room = new Room(sfsRoom.id, sfsRoom.name, sfsRoom.maxUsers, sfsRoom.maxSpectators, sfsRoom.isGame, sfsRoom.isPasswordProtected, sfsRoom.userCount, sfsRoom.spectatorCount);

            this.dispatchEvent(new ExtensionResponseSFSEvent({command: event.params.command,
                    params: event.params.params,
                    room: event.params.room,
                    packetId: event.params.packetId}))
        }

        private function handleHandleshake(event:Object):void
        {
            // TODO: Missing from API documentation.
        }

        private function handleInvitation(event:SFSEvent):void
        {
            this.dispatchEvent(new InvitationSFSEvent(event.params));
        }

        private function handleInvitationReply(event:SFSEvent):void
        {
            this.dispatchEvent(new InvitationReplySFSEvent(event.params));
        }

        private function handleInvitationReplyError(event:SFSEvent):void
        {
            this.dispatchEvent(new InvitationReplyErrorSFSEvent(event.params));
        }

        private function handleLogin(event:SFSEvent):void
        {
            this.dispatchEvent(new LoginSFSEvent(event.params));
        }

        private function handleLoginError(event:SFSEvent):void
        {
            this.dispatchEvent(new LoginErrorSFSEvent(event.params));
        }

        private function handleLogout(event:SFSEvent):void
        {
            this.dispatchEvent(new LogoutSFSEvent());
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
