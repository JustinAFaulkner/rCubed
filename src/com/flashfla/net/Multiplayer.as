package com.flashfla.net
{
    import flash.events.EventDispatcher;

    import com.flashfla.net.sfs.SFSEvents.*;
    import com.flashfla.utils.StringUtil;

    import com.smartfoxserver.v2.SmartFox
    import com.smartfoxserver.v2.core.SFSEvent

    import com.smartfoxserver.v2.entities.*;
    import com.smartfoxserver.v2.entities.managers.*;
    import com.smartfoxserver.v2.entities.data.ISFSObject;
    import com.smartfoxserver.v2.entities.data.SFSObject;

    import com.smartfoxserver.v2.requests.*;

    import com.smartfoxserver.v2.util.ConfigData;
    import com.flashfla.net.events.ErrorEvent;

    public class Multiplayer extends EventDispatcher
    {
        CONFIG::debug
        {
            private static const serverAddress:String = "localhost";
            private static const serverPort:int = 9933;
        }

        CONFIG::release
        {
            private static const serverAddress:String = "flashflashrevolution.com";
            private static const serverPort:int = 8082;
        }


        public static const EVENT_ERROR:String = "ARC_EVENT_ERROR";
        public static const EVENT_CONNECTION:String = "ARC_EVENT_CONNECTION";
        public static const EVENT_LOGIN:String = "ARC_EVENT_LOGIN";
        public static const EVENT_XT_RESPONSE:String = "ARC_EVENT_XT_RESPONSE";
        public static const EVENT_SERVER_MESSAGE:String = "ARC_EVENT_SERVER_MESSAGE";
        public static const EVENT_MESSAGE:String = "ARC_EVENT_MESSAGE";
        public static const EVENT_ROOM_LIST:String = "ARC_EVENT_ROOM_LIST";
        public static const EVENT_ROOM_USER_STATUS:String = "ARC_EVENT_ROOM_USER_STATUS";
        public static const EVENT_ROOM_USER:String = "ARC_EVENT_ROOM_USER";
        public static const EVENT_ROOM_UPDATE:String = "ARC_EVENT_ROOM_UPDATE";
        public static const EVENT_ROOM_JOINED:String = "ARC_EVENT_ROOM_JOINED";
        public static const EVENT_ROOM_LEFT:String = "ARC_EVENT_ROOM_LEFT";
        public static const EVENT_USER_UPDATE:String = "ARC_EVENT_USER_UPDATE";
        public static const EVENT_GAME_START:String = "ARC_EVENT_GAME_START";
        public static const EVENT_GAME_UPDATE:String = "ARC_EVENT_GAME_UPDATE";
        public static const EVENT_GAME_RESULTS:String = "ARC_EVENT_GAME_RESULTS";

        public static const MESSAGE_PUBLIC:int = 0;
        public static const MESSAGE_PRIVATE:int = 1;

        public static const CLASS_ADMIN:int = 1;
        public static const CLASS_BAND:int = 2;
        public static const CLASS_FORUM_MOD:int = 3;
        public static const CLASS_CHAT_MOD:int = 4; // Chat Mod + Profile Mod
        public static const CLASS_MP_MOD:int = 5;
        public static const CLASS_LEGEND:int = 6;
        public static const CLASS_AUTHOR:int = 7; // R1 Music Producer, R1 Simfile Author
        public static const CLASS_VETERAN:int = 8;
        public static const CLASS_USER:int = 9;
        public static const CLASS_BANNED:int = 10;
        public static const CLASS_ANONYMOUS:int = 11;

        public static const COLOURS:Array = [0x000000, 0xFF0000, 0x000000, 0x91FF00, 0x91FF00, 0x91FF00, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000];

        public static const STATUS_NONE:int = 0;
        public static const STATUS_CLEANUP:int = 1;
        public static const STATUS_PICKING:int = 2;
        public static const STATUS_LOADING:int = 3;
        public static const STATUS_LOADED:int = 4;
        public static const STATUS_PLAYING:int = 5;
        public static const STATUS_RESULTS:int = 6;

        public static const MODE_NORMAL:int = 0;
        public static const MODE_BATTLE:int = 1;
        public static const MODE_SCORE_RAW:int = 0;
        public static const MODE_SCORE_COMBO:int = 1;

        public static const GAME_VERSION:String = "R^3";
        public static const SERVER_ZONE:String = "ffr_multiplayer";
        public static const SERVER_EXTENSION:String = "MultiplayerExtension";

        private var server:SmartFox;
        private var eventHandler:SFS2XEventHandler;
        private var roomManager:SFSRoomManager;
        private var userManager:SFSUserManager;

        private var _rooms:Object;
        private var _lobby:Room;

        public var connected:Boolean;
        public var currentUser:MultiplayerUser;

        public var ghostRooms:Vector.<Room>;

        public var inSolo:Boolean;

        public function Multiplayer()
        {
            _rooms = {};
            ghostRooms = new <Room>[];

            server = new SmartFox(true);
            roomManager = new SFSRoomManager(server);
            userManager = new SFSUserManager(server);
            eventHandler = new SFS2XEventHandler(server, roomManager, userManager);


            // Configuration
            eventHandler.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, handleConfigLoadFailure);
            eventHandler.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, handleConfigLoadSuccess);


            // Connectivity
            eventHandler.addEventListener(SFSEvent.CONNECTION, handleConnection);
            eventHandler.addEventListener(SFSEvent.CONNECTION_ATTEMPT_HTTP, handleConnectionAttemptHttp);
            eventHandler.addEventListener(SFSEvent.CONNECTION_LOST, handleConnectionLost);
            eventHandler.addEventListener(SFSEvent.CONNECTION_RESUME, handleConnectionResume);
            eventHandler.addEventListener(SFSEvent.CONNECTION_RETRY, handleConnectionRetry);
            eventHandler.addEventListener(SFSEvent.LOGIN, handleLogin);
            eventHandler.addEventListener(SFSEvent.LOGIN_ERROR, handleLoginError);
            eventHandler.addEventListener(SFSEvent.LOGOUT, handleLogout);
            // eventHandler.addEventListener(SFSEvent.SOCKET_ERROR, handleSocketError);
            // eventHandler.addEventListener(SFSEvent.UDP_INIT, handleUdpInit);
            // eventHandler.addEventListener(SFSEvent.CRYPTO_INIT, handleCryptoInit);


            // Messages
            eventHandler.addEventListener(SFSEvent.ADMIN_MESSAGE, handleAdminMessage);
            eventHandler.addEventListener(SFSEvent.MODERATOR_MESSAGE, handleModeratorMessage);
            eventHandler.addEventListener(SFSEvent.PRIVATE_MESSAGE, handlePrivateMessage);
            eventHandler.addEventListener(SFSEvent.PUBLIC_MESSAGE, handlePublicMessage);


            // Invitations
            // eventHandler.addEventListener(SFSEvent.INVITATION, handleInvitation);
            // eventHandler.addEventListener(SFSEvent.INVITATION_REPLY, handleInvitationReply);
            // eventHandler.addEventListener(SFSEvent.INVITATION_REPLY_ERROR, handleInvitationReplyError);


            // Extraneous
            // eventHandler.addEventListener(SFSEvent.EXTENSION_RESPONSE, handleExtensionResponse, USE_CAPTURE, PRIORITY_VALUE);
            // eventHandler.addEventListener(SFSEvent.OBJECT_MESSAGE, handleObjectMessage);
            // eventHandler.addEventListener(SFSEvent.PING_PONG, handlePingPong);


            // Rooms
            // eventHandler.addEventListener(SFSEvent.ROOM_ADD, handleRoomAdd);
            // eventHandler.addEventListener(SFSEvent.ROOM_CAPACITY_CHANGE, handleRoomCapacityChange);
            // eventHandler.addEventListener(SFSEvent.ROOM_CAPACITY_CHANGE_ERROR, handleRoomCapacityChangeError);
            // eventHandler.addEventListener(SFSEvent.ROOM_CREATION_ERROR, handleRoomCreationError);
            // eventHandler.addEventListener(SFSEvent.ROOM_FIND_RESULT, handleRoomFindResult);
            // eventHandler.addEventListener(SFSEvent.ROOM_GROUP_SUBSCRIBE, handleRoomGroupSubscribe);
            // eventHandler.addEventListener(SFSEvent.ROOM_GROUP_SUBSCRIBE_ERROR, handleRoomGroupSubscribeError);
            // eventHandler.addEventListener(SFSEvent.ROOM_GROUP_UNSUBSCRIBE, handleRoomGroupUnsubscribe);
            // eventHandler.addEventListener(SFSEvent.ROOM_GROUP_UNSUBSCRIBE_ERROR, handleRoomGroupUnsubscribeError);
            // eventHandler.addEventListener(SFSEvent.ROOM_JOIN, handleRoomJoin);
            // eventHandler.addEventListener(SFSEvent.ROOM_JOIN_ERROR, handleRoomJoinError);
            // eventHandler.addEventListener(SFSEvent.ROOM_NAME_CHANGE, handleRoomNameChange);
            // eventHandler.addEventListener(SFSEvent.ROOM_NAME_CHANGE_ERROR, handleRoomNameChangeError);
            // eventHandler.addEventListener(SFSEvent.ROOM_PASSWORD_STATE_CHANGE, handleRoomPasswordStateChange);
            // eventHandler.addEventListener(SFSEvent.ROOM_PASSWORD_STATE_CHANGE_ERROR, handleRoomPasswordStateChangeError);
            // eventHandler.addEventListener(SFSEvent.ROOM_REMOVE, handleRoomRemove);
            // eventHandler.addEventListener(SFSEvent.ROOM_VARIABLES_UPDATE, handleRoomVariablesUpdate);


            // Users
            // eventHandler.addEventListener(SFSEvent.USER_COUNT_CHANGE, handleUserCountChange);
            // eventHandler.addEventListener(SFSEvent.USER_ENTER_ROOM, handleUserEnterRoom);
            eventHandler.addEventListener(SFSEvent.USER_EXIT_ROOM, handleUserExitRoom);
            // eventHandler.addEventListener(SFSEvent.USER_FIND_RESULT, handleUserFindResult);
            // eventHandler.addEventListener(SFSEvent.USER_VARIABLES_UPDATE, handleUserVariablesUpdate);
            // eventHandler.addEventListener(SFSEvent.PLAYER_TO_SPECTATOR, handlePlayerToSpectator);
            // eventHandler.addEventListener(SFSEvent.PLAYER_TO_SPECTATOR_ERROR, handlePlayerToSpectatorError);
            // eventHandler.addEventListener(SFSEvent.SPECTATOR_TO_PLAYER, handleSpectatorToPlayer);
            // eventHandler.addEventListener(SFSEvent.SPECTATOR_TO_PLAYER_ERROR, handleSpectatorToPlayerError);
        }

        // ================================================================== //
        // Configuration
        // ================================================================== //

        private function handleConfigLoadFailure(event:ConfigLoadFailureSFSEvent):void
        {
            // TODO
            trace(event);
        }

        private function handleConfigLoadSuccess(event:ConfigLoadSuccessSFSEvent):void
        {
            // TODO
            trace(event);
        }


        // ================================================================== //
        // Connectivity
        // ================================================================== //

        public function connect():void
        {
            var config:ConfigData = new ConfigData
            {

            }

            server.connect(serverAddress, serverPort);
        }

        public function disconnect(_inSolo:Boolean = false):void
        {
            inSolo = _inSolo;
            server.disconnect();
        }

        public function login(username:String, password:String):void
        {
            if (connected)
            {
                server.send(new LoginRequest(username, password, SERVER_ZONE));
            }
        }

        public function logout():void
        {
            if (connected)
            {
                server.send(new LogoutRequest());
            }
        }

        private function handleConnection(event:ConnectionSFSEvent):void
        {
            connected = event.success;

            if (connected)
            {
                this.dispatchEvent(event);
            }
            else
            {
                dispatchEvent(new ErrorEvent("Could not connect to multiplayer."));
            }
        }

        private function handleConnectionAttemptHttp(event:Object):void
        {
            // TODO
            trace(event);
        }

        private function handleConnectionLost(event:Object):void
        {
            // TODO
            trace(event);
        }

        private function handleConnectionResume(event:Object):void
        {
            // TODO
            trace(event);
        }

        private function handleConnectionRetry(event:Object):void
        {
            // TODO
            trace(event);
        }

        private function handleLogin(event:LoginSFSEvent):void
        {
            this.currentUser = new MultiplayerUser(null, event.user);
        }

        private function handleLoginError(event:Object):void
        {
            // TODO
            trace(event);
        }

        private function handleLogout(event:Object):void
        {
            // TODO
            trace(event);
        }


        // ================================================================== //
        // Messages
        // ================================================================== //

        private function handleAdminMessage(event:AdminMessageSFSEvent):void
        {
            // TODO: Need to dispatch this message upward for rendering.
            trace(StringUtil.htmlUnescape(event.message));
        }

        private function handleModeratorMessage(event:ModeratorMessageSFSEvent):void
        {
            trace(event);
            trace(StringUtil.htmlUnescape(event.message), event.sender);
        }

        private function handlePrivateMessage(event:PrivateMessageSFSEvent):void
        {
            trace(event);
            trace(StringUtil.htmlUnescape(event.message), event.sender);
        }

        private function handlePublicMessage(event:PublicMessageSFSEvent):void
        {
            trace(event);
            trace(StringUtil.htmlUnescape(event.message), event.sender);
        }

        // private function onAdminMessage(event:AdminMessageSFSEvent):void
        // {
        //     
        // }

        // private function onModeratorMessage(event:ModerationMessageSFSEvent):void
        // {
        //     if (event.userId)
        //     {
        //         var user:User = getRoomById(event.roomId).getUser(event.userId);
        //         eventServerMessage(StringUtil.htmlUnescape(event.message), user);
        //     }
        // }

        // ================================================================== //
        // Rooms
        // ================================================================== //

        public function get rooms():Vector.<Room>
        {
            var roomsVec:Vector.<Room> = new <Room>[];

            for (var idx:int in _rooms)
            {
                roomsVec.push(_rooms[idx]);
            }

            return roomsVec;
        }

        private function getRoomById(roomId:int):Room
        {
            return _rooms[roomId];
        }

        public function get lobby():Room
        {
            if (_lobby)
            {
                return _lobby;
            }

            for each (var room:Room in rooms)
            {
                if (room.name == "Lobby")
                {
                    _lobby = room;
                    return _lobby;
                }
            }

            return null;
        }

        public function set lobby(room:Room):void
        {
            _lobby = room;
        }


        // // =================================================== //
        // // STATE MANAGEMENT
        // // =================================================== //

        // /**
        //  * Updates a user's gameplay object from a given room's state
        //  * If the user isn't a player in that room, does nothing.
        //  */
        // private function updateUserGameplayFromRoom(room:Room, user:User):void
        // {
        //     if (!user)
        //         return;

        //     var playerIdx:int = room.getPlayerIndex(user);
        //     if (playerIdx <= 0)
        //     {
        //         user.gameplay = null;
        //         return;
        //     }

        //     var gameplay:Gameplay;
        //     if (user.gameplay)
        //         gameplay = user.gameplay;
        //     else
        //     {
        //         user.gameplay = new Gameplay();
        //         gameplay = user.gameplay;
        //     }

        //     var stats:Array;
        //     var previousStatus:int = gameplay.status;

        //     var prefix:String = "P" + playerIdx;

        //     gameplay.status = int(room.variables[prefix + "_STATE"]);
        //     if (gameplay.status <= STATUS_CLEANUP)
        //     {
        //         if (previousStatus != gameplay.status)
        //         {
        //             gameplay.reset();
        //             room.variables["arc_engine" + playerIdx] = null;
        //             eventUserUpdate(user);
        //         }
        //         return;
        //     }

        //     stats = String(room.variables[prefix + "_GAMESCORES"]).split(":");
        //     gameplay.score = int(stats[0]);
        //     gameplay.amazing = int(stats[1]);
        //     gameplay.perfect = int(stats[2]);
        //     gameplay.good = int(stats[3]);
        //     gameplay.average = int(stats[4]);
        //     gameplay.miss = int(stats[5]);
        //     gameplay.boo = int(stats[6]);
        //     gameplay.combo = int(stats[7]);
        //     gameplay.maxCombo = int(stats[8]);
        //     gameplay.songId = int(room.variables[prefix + "_SONGID"]);
        //     gameplay.statusLoading = int(room.variables[prefix + "_SONGID_PROGRESS"]);
        //     gameplay.life = int(room.variables[prefix + "_GAMELIFE"]);

        //     var engine:String = room.variables["arc_engine" + playerIdx];
        //     if (engine)
        //     {
        //         gameplay.songInfo = ArcGlobals.instance.legacyDecode(JSON.parse(engine));
        //         if (gameplay.songInfo)
        //         {
        //             if (!("level" in gameplay.songInfo) || gameplay.songInfo.level < 0)
        //                 gameplay.songInfo.level = gameplay.songId || -1;
        //         }
        //     }
        //     else
        //     {
        //         var playlist:Playlist = Playlist.instanceCanon;
        //         if (gameplay.songId)
        //             gameplay.songInfo = playlist.playList[gameplay.songId];
        //     }

        //     var replayString:String = room.variables["arc_replay" + playerIdx];
        //     if (replayString)
        //         gameplay.encodedReplay = replayString;
        // }

        // /**
        //  * Sets the `vars` of the current user.
        //  */
        // private function setCurrentUserVariables():void
        // {
        //     var vars:Array = [];

        //     vars["UID"] = currentUser.id;
        //     vars["GAME_VER"] = GAME_VERSION;
        //     vars["MP_LEVEL"] = currentUser.userLevel;
        //     vars["MP_CLASS"] = currentUser.userClass;
        //     vars["MP_COLOR"] = currentUser.userColor;
        //     vars["MP_STATUS"] = currentUser.userStatus;

        //     currentUser.variables = vars;
        // }

        // /**
        //  * Applies the user's `variables` values to its corresponding fields.
        //  */
        // private function applyUserVariables(user:User):void
        // {
        //     if (user != null)
        //     {
        //         var vars:Object = user.variables;

        //         user.siteId = vars["UID"];
        //         user.userLevel = vars["MP_LEVEL"];
        //         user.userClass = vars["MP_CLASS"];
        //         user.userColor = vars["MP_COLOR"];
        //         user.userStatus = vars["MP_STATUS"];
        //     }
        // }

        // private function removeRoom(room:Room):void
        // {
        //     delete _rooms[room.id];
        // }

        // private function addRoom(room:Room):void
        // {
        //     room.connection = this;
        //     _rooms[room.id] = room;

        //     if (room.name == "Lobby")
        //         lobby = room;

        //     updateRoom(room);
        // }

        // private function updateRoom(room:Room):void
        // {
        //     if (room == null)
        //         return;

        //     // Do more specific updates if user is in room
        //     if (room.hasUser(currentUser))
        //     {
        //         var currentUserIsPlayer:Boolean = room.isPlayer(currentUser);
        //         var roomPlayers:Vector.<User> = room.players;

        //         // Update each player's gameplay
        //         var anyUserStatusChanged:Boolean = false;
        //         var anyUserSongNameChanged:Boolean = false;
        //         for each (var user:User in roomPlayers)
        //         {
        //             var previousUserStatus:int = user.gameplay ? user.gameplay.status ? user.gameplay.status : -1 : -1;
        //             var previousSongName:String = user.gameplay ? user.gameplay.songInfo ? user.gameplay.songInfo.name : "" : "";

        //             updateUserGameplayFromRoom(room, user);

        //             if (previousUserStatus != user.gameplay.status)
        //                 anyUserStatusChanged = true;

        //             if (previousSongName != (user.gameplay.songInfo ? user.gameplay.songInfo.name : ""))
        //                 eventUserUpdate(user);
        //         }

        //         // Process gameplay status changes for game start/end
        //         if (anyUserStatusChanged)
        //         {
        //             if (room.isAllPlayersInStatus(STATUS_LOADED) && room.isAllPlayersSameSong())
        //             {
        //                 currentUser.gameplay.status = STATUS_PLAYING;

        //                 reportSongStart(room);
        //                 sendCurrentUserStatus(room);

        //                 if (currentUserIsPlayer)
        //                     eventGameStart(room);
        //             }
        //             else if (currentUserIsPlayer && currentUser.gameplay.status == STATUS_RESULTS)
        //             {
        //                 reportSongEnd(room);
        //                 eventGameResults(room);

        //                 eventUserUpdate(currentUser);
        //             }
        //         }
        //     }

        //     // Update room metadata
        //     room.level = room.variables["GAME_LEVEL"];
        //     room.mode = room.variables["GAME_MODE"];
        //     room.scoreMode = room.variables["GAME_SCORE"];
        //     room.ranked = room.variables["GAME_RANKED"];
        // }

        // private function getRoomUserById(room:Room, userId:int):User
        // {
        //     if (room == null)
        //     {
        //         return null;
        //     }

        //     return room.getUser(userId);
        // }


        // // =================================================== //
        // // SERVER REQUESTS
        // // =================================================== //

        public function sendAdministratorMessageToZone(message:String):void
        {
            // TODO
        }

        public function sendAdministratorMessageToRoom(message:String, roomId:int):void
        {
            var sfsRoom:Room = roomManager.getRoomById(roomId);
            // TODO
            trace("send admin messag: ", sfsRoom);
        }

        public function sendAdministratorMessageToUser(message:String, userId:int):void
        {
            // TODO
        }

        public function sendServerMessage(message:String, target:Object = null):void
        {
            if (connected)
            {
                var recipMode:MessageRecipientMode = new MessageRecipientMode(MessageRecipientMode.TO_ZONE, server.currentZone);

                if (target.userID != null)
                {
                    recipMode = new MessageRecipientMode(MessageRecipientMode.TO_USER, target.userID);
                }
                else if (target.roomID != null)
                {
                    recipMode = new MessageRecipientMode(MessageRecipientMode.TO_ROOM, server.lastJoinedRoom);
                }

                server.send(new ModeratorMessageRequest(message, recipMode));
            }
        }

        public function nukeRoom(room:Room):void
        {
            if (connected && room)
            {
                var params:ISFSObject = new SFSObject();
                params.putInt("roomt", room.id);
                server.send(new ExtensionRequest("nuke_room", params));
            }
        }

        // public function muteUser(user:User, time:int = 2, ipBan:Boolean = false):void
        // {
        //     if (connected && user)
        //     {
        //         var params:ISFSObject = new SFSObject();
        //         params.putInt("user", user.id);
        //         params.putInt("bantime", time);
        //         params.putInt("ip", (ipBan ? 1 : 0));
        //         server.send(new ExtensionRequest("mute_user", params));
        //     }
        // }

        // public function banUser(user:User, time:int = 2, ipBan:Boolean = false):void
        // {
        //     if (connected && user)
        //     {
        //         var params:ISFSObject = new SFSObject();
        //         params.putInt("user", user.id);
        //         params.putInt("bantime", time);
        //         params.putInt("ip", (ipBan ? 1 : 0));
        //         server.send(new ExtensionRequest("ban_user", params));
        //     }
        // }

        // public function sendHTMLMessage(message:String, target:Object = null):void
        // {
        //     if (connected)
        //     {
        //         var params:ISFSObject = new SFSObject();
        //         params.putUtfString("m", message);

        //         if (target == null)
        //         {
        //             params.putInt("t", MessageRecipientMode.TO_ZONE);
        //             params.putInt("v", null);
        //         }
        //         else if (target.id != null)
        //         {
        //             params.putInt("t", MessageRecipientMode.TO_USER);
        //             params.putInt("v", target.id);
        //         }
        //         // TODO: This is broken and will never be hit.
        //         else if (target.id != null)
        //         {
        //             params.putInt("t", MessageRecipientMode.TO_ROOM);
        //             params.putInt("v", target.id);
        //         }

        //         server.send(new ExtensionRequest("html_message", params));
        //     }
        // }

        // public function getUserList(room:Room):void
        // {
        //     if (connected && room)
        //     {
        //         var params:ISFSObject = new SFSObject();
        //         params.putInt("roomt", room.id);
        //         server.send(new ExtensionRequest("getUserList", params));
        //     }
        // }

        // // TODO: Unreferenced function with uncertain usage.
        // public function getUserVariables(... users):void
        // {
        //     if (connected)
        //     {
        //         var params:ISFSObject = new SFSObject();
        //         //params.putSFSArray("users", users);
        //         server.send(new ExtensionRequest("getUserVariables", params));
        //     }
        // }

        // public function getMultiplayerLevel():void
        // {
        //     if (connected)
        //     {
        //         server.send(new ExtensionRequest("getMultiplayerLevel", null));
        //     }
        // }

        // public function reportSongStart(room:Room):void
        // {
        //     if (connected)
        //     {
        //         server.send(new ExtensionRequest("playerStart", null, getRoomById(room.id).));
        //     }
        // }

        // public function reportSongEnd(room:Room):void
        // {
        //     if (connected)
        //     {
        //         server.send(new ExtensionRequest("playerFinish", null, getRoomById(room.id)));
        //     }
        // }

        // public function refreshRooms():void
        // {
        //     if (connected)
        //     {
        //         // TODO: I'm pretty sure this is kept up to date automatically now?
        //         server.roomList;
        //     }
        // }

        // /**
        //  * Sends a request to the server to join a specific room as a player or not.
        //  * Optionally, provide a password.
        //  */
        // public function joinRoom(room:Room, asPlayer:Boolean = true, password:String = ""):void
        // {
        //     if (!connected || !room)
        //         return;

        //     if (room.isGameRoom)
        //         asPlayer &&= room.userCount < Room.MAX_PLAYERS;

        //     // TODO: Check that NaN successfully leaves the last joined room.
        //     // http://docs2x.smartfoxserver.com/api-docs/asdoc/com/smartfoxserver/v2/requests/JoinRoomRequest.html#JoinRoomRequest()
        //     server.send(new JoinRoomRequest(room.id, password, NaN, !asPlayer));
        // }

        // public function joinLobby():void
        // {
        //     joinRoom(lobby, true);
        // }

        // /**
        //  * Sends a request to the server to leave a specific room.
        //  */
        // public function leaveRoom(room:Room):void
        // {
        //     if (connected && room)
        //     {
        //         clearCurrentUserRoomVariables(room);

        //         server.send(new LeaveRoomRequest(getRoomById(room.id)));
        //     }
        // }

        // /**
        //  * Attempts to switch the current user's state (player/spectator) in the given room.
        //  * If the user is trying to become a player, it must currently be a spectator
        //  * and not playing in any other room.
        //  */
        // public function switchRole(room:Room):void
        // {
        //     if (!connected || !room)
        //         return;

        //     if (room.isPlayer(currentUser))
        //     {
        //         // Cannot switch mode while playing
        //         if (currentUser.gameplay.status == STATUS_PLAYING)
        //             return;

        //         server.switchPlayer(room.id);
        //     }
        //     else
        //     {
        //         // Cannot switch to player if already a player in another room
        //         if (currentUser.isPlayer)
        //         {
        //             eventError("You cannot be a player in more than one game");
        //             return;
        //         }

        //         // Cannot switch to player if player slots are filled
        //         if (room.playerCount >= 2)
        //             return;

        //         server.switchSpectator(room.id);
        //     }
        // }

        // /**
        //  * Builds a request to create a new room and sends it to the server.
        //  */
        // public function createRoom(name:String, password:String = "", maxUsers:int = 2, maxSpectators:int = 100):void
        // {
        //     if (connected && name)
        //     {
        //         var params:Object = {};
        //         params.name = name;
        //         params.password = password;
        //         params.maxUsers = maxUsers;
        //         params.maxSpectators = maxSpectators;
        //         params.isGame = true;
        //         params.exitCurrentRoom = false;
        //         params.uCount = true;
        //         params.joinAsSpectator = currentUser.isPlayer;
        //         params.vars = [{name: "GAME_LEVEL", val: currentUser.userLevel, persistent: true},
        //             {name: "GAME_MODE", val: MODE_NORMAL, persistent: true},
        //             {name: "GAME_SCORE", val: MODE_SCORE_RAW, persistent: true},
        //             {name: "GAME_RANKED", val: true, persistent: true}];

        //         server.createRoom(params);
        //     }
        // }

        public function sendMessage(message:String, roomId:int, escape:Boolean = true):void
        {
            if (message.length > 0)
            {
                server.send(new PublicMessageRequest(escape ? StringUtil.htmlEscape(message) : message, null, getRoomById(roomId)));
            }
        }

        public function sendPrivateMessage(message:String, userId:int):void
        {
            if (message.length > 0)
            {
                server.send(new PrivateMessageRequest(StringUtil.htmlEscape(message), userId));
            }
        }

        // /**
        //  * Formats and sends the room variables for the currentUser to the server.
        //  */
        // public function sendRoomVariables(room:Room, data:Object, changeOwnership:Boolean = true):void
        // {
        //     var varArray:Array = [];
        //     for (var name:String in data)
        //         varArray.push({name: name, val: data[name]});

        //     if (varArray.length > 0)
        //         server.setRoomVariables(varArray, room.id, changeOwnership);
        // }

        // /**
        //  * Formats empty room variables for the currentUser and sends them to the server.
        //  */
        // private function clearCurrentUserRoomVariables(room:Room):void
        // {
        //     if (!room.isGameRoom)
        //         return;

        //     var vars:Object = {};
        //     var currentUserIdx:int = room.getPlayerIndex(currentUser);

        //     if (currentUserIdx > 0)
        //     {
        //         var prefix:String = "P" + currentUserIdx;

        //         vars[prefix + "_NAME"] = null;
        //         vars[prefix + "_UID"] = null;
        //         vars[prefix + "_SONGID_PROGRESS"] = null;
        //         vars[prefix + "_SONGID"] = null;

        //         vars["arc_engine" + currentUser.id] = null;
        //         vars["arc_replay" + currentUser.id] = null;
        //     }

        //     // Send room vars to server
        //     sendRoomVariables(room, vars);
        // }

        // /**
        //  * Sends the current user's "player" variables (if any) to the server.
        //  */
        // private function sendCurrentUserRoomVariables(room:Room):void
        // {
        //     if (!room.isGameRoom)
        //         return;

        //     var vars:Object = {};
        //     var currentUserIdx:int = room.getPlayerIndex(currentUser);

        //     if (currentUserIdx > 0)
        //     {
        //         var prefix:String = "P" + currentUserIdx;

        //         vars[prefix + "_NAME"] = currentUser.name;
        //         vars[prefix + "_UID"] = currentUser.id;

        //         // If no opponents, set the room's level to the currentUser's level
        //         if (!room.playerCount > 1)
        //             vars["GAME_LEVEL"] = currentUser.userLevel;

        //         sendRoomVariables(room, vars);
        //     }
        // }

        // /**
        //  * Builds a request to update the current user's gameplay status
        //  * in the specified room and sends it to the server.
        //  */
        // public function sendCurrentUserStatus(room:Room):void
        // {
        //     if (!room.hasUser(currentUser))
        //         return;

        //     var vars:Object = {};
        //     var user:User = currentUser;
        //     var gameplay:Gameplay = currentUser.gameplay;
        //     var songEngine:Object = ArcGlobals.instance.legacyEncode(gameplay.songInfo);

        //     var prefix:String = "P" + user.playerIdx;

        //     // Ordering is important
        //     var gamescores:Array = [gameplay.score,
        //         gameplay.amazing,
        //         gameplay.perfect,
        //         gameplay.good,
        //         gameplay.average,
        //         gameplay.miss,
        //         gameplay.boo,
        //         gameplay.combo,
        //         gameplay.maxCombo];

        //     vars[prefix + "_GAMESCORES"] = StringUtil.join(":", gamescores);
        //     vars[prefix + "_STATE"] = int(gameplay.status);
        //     vars[prefix + "_GAMELIFE"] = int(gameplay.life * 24 / 100);
        //     vars[prefix + "_SONGID"] = (gameplay.songInfo == null ? gameplay.songId : int(gameplay.songInfo.level));
        //     vars[prefix + "_SONGID_PROGRESS"] = int(gameplay.statusLoading);

        //     if (songEngine)
        //         vars["arc_engine" + user.playerIdx] = JSON.stringify(songEngine);
        //     else if (gameplay.songInfo === null || (gameplay.songInfo && !gameplay.songInfo.engine))
        //         vars["arc_engine" + user.playerIdx] = null;

        //     vars["arc_replay" + user.playerIdx] = gameplay.encodedReplay || null;

        //     sendRoomVariables(room, vars);
        // }

        // /**
        //  * Builds a request to update the current user's gameplay score
        //  * in the specified room and sends it to the server.
        //  */
        // public function sendCurrentUserScore(room:Room):void
        // {
        //     if (!room.hasUser(currentUser))
        //         return;

        //     var vars:Object = {};
        //     var user:User = currentUser;
        //     var gameplay:Gameplay = currentUser.gameplay;

        //     var prefix:String = "P" + user.playerIdx;

        //     // Ordering is important
        //     var gamescores:Array = [gameplay.score,
        //         gameplay.amazing,
        //         gameplay.perfect,
        //         gameplay.good,
        //         gameplay.average,
        //         gameplay.miss,
        //         gameplay.boo,
        //         gameplay.combo,
        //         gameplay.maxCombo];

        //     vars[prefix + "_GAMESCORES"] = StringUtil.join(":", gamescores);
        //     vars[prefix + "_GAMELIFE"] = int(gameplay.life * 24 / 100);

        //     sendRoomVariables(room, vars);
        // }

        // TODO: MOVE ALL OF THESE CALLS UP TO THEIR MATCHING FUNCTION
        // // =================================================== //
        // // MP EVENT DISPATCHERS
        // // =================================================== //

        private function eventError(message:String):void
        {

        }

        // private function eventServerMessage(message:String, user:User = null):void
        // {
        //     dispatchEvent(new ServerMessageEvent({message: StringUtil.stripMessage(message), user: user}));
        // }

        // private function eventMessage(type:int, room:Room, user:User, message:String):void
        // {
        //     dispatchEvent(new MessageEvent({msgType: type, room: room, user: user, message: StringUtil.stripMessage(message)}));
        // }

        // private function eventRoomUserStatus(room:Room, user:User):void
        // {
        //     dispatchEvent(new RoomUserStatusEvent({room: room, user: user}));
        // }

        // private function eventRoomJoined(room:Room):void
        // {
        //     dispatchEvent(new RoomJoinedEvent({room: room}));
        // }

        // private function eventRoomLeft(room:Room):void
        // {
        //     dispatchEvent(new RoomLeftEvent({room: room}));
        // }

        // private function eventRoomUpdate(room:Room, roomList:Boolean = false):void
        // {
        //     dispatchEvent(new RoomUpdateEvent({room: room, roomList: roomList}));
        // }

        // private function eventRoomUser(room:Room, user:User):void
        // {
        //     dispatchEvent(new RoomUserEvent({room: room, user: user}));
        // }

        // private function eventRoomList():void
        // {
        //     dispatchEvent(new RoomListEvent());
        // }

        // private function eventUserUpdate(user:User):void
        // {
        //     dispatchEvent(new UserUpdateEvent({user: user}));
        // }

        // private function eventGameStart(room:Room):void
        // {
        //     dispatchEvent(new GameStartEvent({room: room}));
        // }

        // private function eventGameResults(room:Room):void
        // {
        //     dispatchEvent(new GameResultsEvent({room: room}));
        // }


        // // =================================================== //
        // // SFS EVENT HANDLERS
        // // =================================================== //



        // private function onConnectionLost(event:ConnectionLostSFSEvent):void
        // {
        //     connected = false;

        //     eventConnection();
        //     if (inSolo == false)
        //         eventError("Multiplayer Connection Lost");
        // }

        // CONFIG::debug
        // {
        //     private function onDebugMessage(event:DebugMessageSFSEvent):void
        //     {
        //         //trace("arc_msg: SFS: " + event.params.message);
        //     }
        // }

        // private function onCreateRoomError(event:CreateRoomErrorSFSEvent):void
        // {
        //     eventError("Create Room Failed: " + event.error);
        // }

        // private function onExtensionResponse(event:ExtensionResponseSFSEvent):void
        // {
        //     var data:Object = event.dataObj;
        //     switch (data._cmd)
        //     {
        //         case "logOK":
        //             currentUser.loggedIn = true;
        //             currentUser.name = data.name;
        //             currentUser.userClass = data.userclass;
        //             currentUser.userColor = data.usercolor;
        //             currentUser.userLevel = data.userlevel;
        //             currentUser.id = data.userID;
        //             currentUser.siteId = int(data.siteID);
        //             currentUser.isModerator = (data.mod || data.userclass == CLASS_ADMIN || data.userclass == CLASS_FORUM_MOD || data.userclass == CLASS_CHAT_MOD || data.userclass == CLASS_MP_MOD);
        //             currentUser.isAdmin = (data.userclass == CLASS_ADMIN);
        //             currentUser.userStatus = 0;

        //             setCurrentUserVariables();

        //             // TODO: Check the usage of these and if they're absolutely needed internally for SFS
        //             server.myUserId = currentUser.id;
        //             server.myUserName = currentUser.name;
        //             server.amIModerator = currentUser.isModerator;
        //             server.playerId = -1;

        //             eventLogin();
        //             refreshRooms();
        //             break;
        //         case "logKO":
        //             currentUser.loggedIn = false;

        //             eventLogin();
        //             eventError("Login Failed: " + data.err);
        //             break;
        //         case "specStatus":
        //             /*var player1:int = int(data.p1i);
        //                var player2:int = int(data.p2i);
        //                if (player1 > 0) {

        //                }
        //                data.status;
        //                data.p2i;
        //                data.p2n;*/
        //             break;
        //         case "stop": // when someone closes a room apparently
        //             //data.n; // username
        //             break;
        //         case "html_message":
        //             data.uid = getRoomUserById(data.rid, data.uid);
        //             data.rid = getRoom(data.rid);
        //             dispatchEvent(new ExtensionResponseEvent({data: data}));
        //             break;
        //     }
        // }

        // private function onLogout(event:LogoutSFSEvent):void
        // {
        //     currentUser.loggedIn = false;
        //     eventLogin();
        // }



        // private function onPlayerSwitched(event:PlayerSwitchedSFSEvent):void
        // {
        //     var room:Room = getRoomById(event.roomId);
        //     var user:User = event.userId == 0 ? currentUser : getRoomUserById(room, event.userId);

        //     if (!user)
        //         return;

        //     if (user == currentUser)
        //         clearCurrentUserRoomVariables(room);

        //     room.removePlayer(user.playerIdx);
        //     user.isPlayer = false;
        //     user.playerIdx = -1;
        //     user.gameplay = null;

        //     room.specCount += 1;
        //     room.userCount -= 1;

        //     updateRoom(room);

        //     eventRoomUserStatus(room, user);
        // }

        // private function onSpectatorSwitched(event:SpectatorSwitchedSFSEvent):void
        // {
        //     var room:Room = getRoomById(event.roomId);
        //     var user:User = event.userId == 0 ? currentUser : getRoomUserById(room, event.userId);

        //     if (!user)
        //         return;

        //     var newPlayerIdx:int = room.addPlayer(user);
        //     if (newPlayerIdx > 0)
        //     {
        //         user.isPlayer = true;
        //         user.playerIdx = newPlayerIdx;
        //     }

        //     if (user == currentUser)
        //         sendCurrentUserRoomVariables(room);

        //     room.specCount -= 1;
        //     room.userCount += 1;

        //     updateRoom(room);

        //     eventRoomUserStatus(room, user);
        // }

        // private function onPrivateMessage(event:PrivateMessageSFSEvent):void
        // {
        //     if (event.userId == currentUser.id)
        //         return; // Ignore PM events sent by yourself because they don't include the recipient for some stupid reason

        //     var room:Room = getRoomById(event.roomId);
        //     var user:User = getRoomUserById(room, event.userId);

        //     if (user)
        //         eventMessage(MESSAGE_PRIVATE, room, user, StringUtil.htmlUnescape(event.message));
        // }

        // private function onPublicMessage(event:PublicMessageSFSEvent):void
        // {
        //     var room:Room = getRoomById(event.roomId);
        //     var user:User = getRoomUserById(room, event.userId);

        //     if (user)
        //         eventMessage(MESSAGE_PUBLIC, room, user, StringUtil.htmlUnescape(event.message));
        // }

        // private function onRoomListUpdate(event:RoomListUpdateSFSEvent):void
        // {
        //     for each (var evtRoom:Room in event.roomList)
        //     {
        //         var room:Room = getRoom(evtRoom);
        //         if (!room)
        //             addRoom(evtRoom);
        //         else
        //         {
        //             room.userCount = evtRoom.userCount;
        //             room.specCount = evtRoom.specCount;

        //             eventRoomUpdate(room);
        //         }
        //     }

        //     eventRoomList();
        // }

        // private function onRoomVariablesUpdate(event:RoomVariablesUpdateSFSEvent):void
        // {
        //     var room:Room = getRoom(event.room);

        //     if (!room)
        //         return;

        //     // Apply new vars to the room from the event
        //     room.applyVariablesFromOtherRoom(event.room);

        //     // If the current user is not in the room, dont bother updating states further
        //     if (!room.hasUser(currentUser))
        //         return;
        //     // If the room isn't a game room, nothing else needs to be done
        //     if (!room.isGameRoom)
        //         return;

        //     // Update the room state
        //     updateRoom(room);
        //     // TODO: Check roomList param validity
        //     eventRoomUpdate(room, true);
        // }

        // private function onRoomAdded(event:RoomAddedSFSEvent):void
        // {
        //     addRoom(event.room);
        //     eventRoomList();
        // }

        // private function onRoomDeleted(event:RoomDeletedSFSEvent):void
        // {
        //     var room:Room = getRoomById(event.roomId);

        //     if (room.getPlayerIndex(currentUser) > 0)
        //     {
        //         currentUser.isPlayer = false;
        //         currentUser.playerIdx = -1;
        //     }

        //     removeRoom(room);
        //     if (room.hasUser(currentUser))
        //         ghostRooms.push(room);

        //     eventRoomList();
        // }

        // /**
        //  * Called when the current player has left a room
        //  */
        // private function onLeftRoom(event:LeftRoomSFSEvent):void
        // {
        //     var room:Room = getRoomById(event.roomId);
        //     if (room == null)
        //     {
        //         for each (var ghost:Room in ghostRooms)
        //         {
        //             if (ghost.id == event.roomId)
        //             {
        //                 room = ghost;
        //                 ghostRooms = ghostRooms.filter(function(item:Room, index:int, vec:Vector.<Room>):Boolean
        //                 {
        //                     return item.id != ghost.id;
        //                 });
        //                 break;
        //             }
        //         }
        //     }
        //     else
        //     {
        //         if (room.removePlayer(currentUser.playerIdx))
        //         {
        //             currentUser.isPlayer = false;
        //             currentUser.playerIdx = -1;
        //             currentUser.gameplay = null;
        //         }

        //         room.clearPlayers();
        //         room.clearUsers();
        //     }

        //     updateRoom(room);

        //     eventRoomLeft(room);
        // }

        // /**
        //  * Called when the current player has joined a room.
        //  * This event populates the joined room with a user list.
        //  */
        // private function onJoinedRoom(event:JoinedRoomSFSEvent):void
        // {
        //     var room:Room = getRoom(event.room);

        //     // Adds the users to the room
        //     for each (var user:User in event.users)
        //     {
        //         if (user.id == currentUser.id)
        //         {
        //             // This is necessary since the server does not provide `vars` for the logged in user
        //             // on `joinOK` events. These `vars` are only provided in the `logOK` part of a `xtRes` event.
        //             server.setUserVariables(currentUser.variables);

        //             room.addUser(currentUser);

        //             // Current user always gets -1 as a playerIdx on room join, so attempt to add it to players
        //             if (room.isGameRoom && !currentUser.isPlayer)
        //             {
        //                 var newPlayerIdx:int = room.addPlayer(currentUser);

        //                 if (newPlayerIdx > 0)
        //                 {
        //                     currentUser.isPlayer = true;
        //                     currentUser.playerIdx = newPlayerIdx;
        //                 }
        //             }
        //         }
        //         else
        //         {
        //             applyUserVariables(user);

        //             room.addUser(user);

        //             // If the user has a positive playerIdx, insert it in the room's players
        //             if (room.isGameRoom && user.playerIdx > 0)
        //                 room.setPlayer(user.playerIdx, user);
        //         }
        //     }

        //     updateRoom(room);

        //     sendCurrentUserRoomVariables(room);
        //     if (room.isPlayer(currentUser))
        //         sendCurrentUserStatus(room);

        //     // Propagate the events
        //     eventUserUpdate(currentUser);
        //     eventRoomJoined(room);
        // }

        // private function onJoinRoomError(event:JoinRoomErrorSFSEvent):void
        // {
        //     eventError("Join Failed: " + event.error);
        // }

        // private function onUserCountChange(event:UserCountChangeSFSEvent):void
        // {
        //     // TODO: See if this is necessary
        // }

        // /**
        //  * Called when another user enters any room that the current user is in
        //  */
        // private function onUserEnterRoom(event:UserEnterRoomSFSEvent):void
        // {
        //     var room:Room = getRoomById(event.roomId);
        //     var user:User = event.user;

        //     // TODO: Check if actually needed, since uVars is called right after
        //     applyUserVariables(user);

        //     room.addUser(user);

        //     // Always attempt to add a new user to a room as a player
        //     if (room.isGameRoom)
        //         if (room.setPlayer(user.playerIdx, user))
        //             updateUserGameplayFromRoom(room, user);

        //     eventRoomUser(room, user);
        //     eventRoomUpdate(room);
        // }

        // /**
        //  * Called when another user leaves any room that the current user is in
        //  */
        // private function onUserLeftRoom(event:UserLeftRoomSFSEvent):void
        // {
        //     var room:Room = getRoomById(event.roomId);
        //     var user:User = getRoomUserById(room, event.userId);

        //     if (user)
        //     {
        //         var playerIdx:int = room.getPlayerIndex(user);
        //         if (playerIdx > 0 && room.removePlayer(playerIdx))
        //             user.playerIdx = -1;

        //         room.removeUser(user.id);
        //     }

        //     eventRoomUser(room, user);
        //     eventRoomUpdate(room);
        // }

        // private function onUserVariablesUpdate(event:UserVariablesUpdateSFSEvent):void
        // {
        //     for each (var room:Room in rooms)
        //     {
        //         var user:User = room.getUser(event.user.id);
        //         if (!user)
        //             continue;

        //         user.setVariables(event.user.variables)
        //         applyUserVariables(user);

        //         eventUserUpdate(user);
        //         return;
        //     }
        // }

        private function handleUserExitRoom(event:UserExitRoomSFSEvent):void
        {
            this.dispatchEvent(event);
        }
    }
}
