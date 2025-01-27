package
{
    import by.blooddy.crypto.MD5;
    import classes.FileTracker;
    import classes.chart.Song;
    import com.flashfla.utils.SystemUtil;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.utils.ByteArray;

    /**
     * Contains methods that deal with AIR specific things, in regular flash builds, these are either excluded or stubbed.
     */
    public class AirContext
    {
        // Windows will store files in the current folder, other OS will use the application storage folder.
        public static var STORAGE_PATH:File;
        {
            if (SystemUtil.OS.toLowerCase().indexOf("win") == -1)
            {
                STORAGE_PATH = File.applicationStorageDirectory;
            }
            else
            {
                STORAGE_PATH = new File(File.applicationDirectory.nativePath);
            }
        }

        static public function serverVersionHigher(serverVersionString:String):int
        {
            var gameVersion:Array = Constant.AIR_VERSION.split(".").map(function(item:*, index:int, array:Array):int
            {
                return parseInt(item);
            });

            var serverVersion:Array = serverVersionString.split(".").map(function(item:*, index:int, array:Array):int
            {
                return parseInt(item);
            });

            var length:int = Math.max(gameVersion.length, serverVersion.length);
            for (var i:int = 0; i < length; i++)
            {
                var thisPart:int = i < gameVersion.length ? gameVersion[i] : 0;
                var thatPart:int = i < serverVersion.length ? serverVersion[i] : 0;

                if (thisPart < thatPart)
                    return -1;
                if (thisPart > thatPart)
                    return 1;
            }
            return 0;
        }

        public static function initFolders():void
        {
            // song cache
            var folder:File = STORAGE_PATH.resolvePath(Constant.SONG_CACHE_PATH);
            if (!folder.exists)
                folder.createDirectory();

            // replays
            folder = STORAGE_PATH.resolvePath(Constant.REPLAY_PATH);
            if (!folder.exists)
                folder.createDirectory();

            // noteskins
            folder = STORAGE_PATH.resolvePath(Constant.NOTESKIN_PATH);
            if (!folder.exists)
                folder.createDirectory();
        }

        public static function createFileName(file_name:String, replace:String = ""):String
        {
            // Remove chars not allowed in Windows filename \ / : * ? " < > |
            file_name = file_name.replace(/[~\\\/:\*\?"<>\|]/g, replace);

            // Trim leading and trailing whitespace.
            file_name = file_name.replace(/^\s+|\s+$/gs, replace);

            return file_name;
        }

        static public function getLoaderContext():LoaderContext
        {
            var lc:LoaderContext = new LoaderContext();
            lc.applicationDomain = new ApplicationDomain(null);
            lc.allowCodeImport = true;
            return lc;
        }

        static public function getSongCachePath(song:Song):String
        {
            return Constant.SONG_CACHE_PATH + (song.songInfo.engine ? MD5.hash(song.songInfo.engine.id) + "/" + MD5.hash(song.songInfo.level_id.toString()) : '57fea2a7e69445179686b7579d5118ef/' + MD5.hash(song.id.toString())) + "/";
        }

        static public function getReplayPath(song:Song):String
        {
            return Constant.REPLAY_PATH + (song.songInfo.engine ? createFileName(song.songInfo.engine.id) : Constant.BRAND_NAME_SHORT_LOWER) + "/";
        }

        static public function encodeData(rawData:ByteArray, key:uint = 0):ByteArray
        {
            if (key == 0)
                return rawData;

            // Do some XOR stuff on the ByteArray.
            var sp:uint = rawData.position;
            rawData.position = 0;
            var storeData:ByteArray = new ByteArray();
            storeData.writeBytes(rawData);
            for (var bi:uint = 4; bi < rawData.length; bi += 4)
            {
                storeData[bi] ^= (key + bi) % 0xFF;
            }
            rawData.position = sp;
            storeData.position = 0;
            return storeData;
        }

        static private function e_fileError(e:Event):void
        {
            trace(e);
        }

        static public function getAppFile(path:String):File
        {
            return STORAGE_PATH.resolvePath(path);
        }

        static public function doesFileExist(path:String):Boolean
        {
            return STORAGE_PATH.resolvePath(path).exists;
        }

        static public function writeFile(file:File, bytes:ByteArray, key:uint = 0, errorCallback:Function = null):File
        {
            var fileStream:FileStream = new FileStream();
            fileStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, (errorCallback != null ? errorCallback : e_fileError));
            fileStream.addEventListener(IOErrorEvent.IO_ERROR, (errorCallback != null ? errorCallback : e_fileError));
            fileStream.open(file, FileMode.WRITE);
            fileStream.writeBytes(encodeData(bytes, key));
            fileStream.close();

            return file;
        }

        static public function readFile(file:File, key:uint = 0, errorCallback:Function = null):ByteArray
        {
            if (file.exists)
            {
                var fileStream:FileStream = new FileStream();
                fileStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, (errorCallback != null ? errorCallback : e_fileError));
                fileStream.addEventListener(IOErrorEvent.IO_ERROR, (errorCallback != null ? errorCallback : e_fileError));
                var readData:ByteArray = new ByteArray();
                fileStream.open(file, FileMode.READ);
                fileStream.readBytes(readData);
                fileStream.close();

                return encodeData(readData, key);
            }
            return null;
        }

        static public function readTextFile(file:File, errorCallback:Function = null):String
        {
            if (file.exists)
            {
                var fileStream:FileStream = new FileStream();
                fileStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, (errorCallback != null ? errorCallback : e_fileError));
                fileStream.addEventListener(IOErrorEvent.IO_ERROR, (errorCallback != null ? errorCallback : e_fileError));
                fileStream.open(file, FileMode.READ);
                var data:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
                fileStream.close();

                return data;
            }
            return null;
        }

        static public function writeTextFile(file:File, data:String, errorCallback:Function = null):File
        {
            if (data == null || data.length == 0)
                return file;

            var fileStream:FileStream = new FileStream();
            fileStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, (errorCallback != null ? errorCallback : e_fileError));
            fileStream.addEventListener(IOErrorEvent.IO_ERROR, (errorCallback != null ? errorCallback : e_fileError));
            fileStream.open(file, FileMode.WRITE);
            fileStream.writeUTFBytes(data);
            fileStream.close();

            return file;
        }

        static public function deleteFile(file:File):Boolean
        {
            if (file.exists)
            {
                file.moveToTrash();
                return true;
            }
            return false;
        }

        public static function getFileSize(file:File, track:FileTracker = null, track_file_paths:Boolean = false):FileTracker
        {
            if (!track)
                track = new FileTracker();

            if (file == null || file.exists == false)
            {
                return track;
            }
            if (file.isDirectory)
            {
                track.dirs++;
                var files:Array = file.getDirectoryListing();
                for each (var f:File in files)
                {
                    if (f.isDirectory)
                    {
                        getFileSize(f, track, track_file_paths);
                    }
                    else
                    {
                        if (track_file_paths)
                            track.file_paths.push(f.nativePath);
                        track.files++;
                        track.size += f.size;
                    }
                }
            }
            else
            {
                if (track_file_paths)
                    track.file_paths.push(file.nativePath);
                track.files++;
                track.size += file.size;
            }
            return track;
        }
    }
}
