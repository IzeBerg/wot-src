package net.wg.gui.components.common.video
{
   import flash.events.Event;
   import flash.events.NetStatusEvent;
   import flash.media.SoundTransform;
   import flash.media.Video;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SimpleVideoPlayer extends UIComponentEx
   {
      
      private static const VIDEO_SOURCE_INVALID:String = "loadVideo";
      
      private static const SELECTED_SUBTITLE_TRACK_INVALID:String = "selSubTitleInv";
      
      private static const SELECTED_AUDIO_TRACK_INVALID:String = "selAudioInv";
      
      private static const SOUND_LEVEL_INVALID:String = "soundLvlChanged";
      
      private static const AUDIO_TRACK_PROP_NAME:String = "audioTrack";
      
      private static const SUBTITLE_TRACK_PROP_NAME:String = "subtitleTrack";
      
      private static const INV_BUFFER_TIME:String = "invBufferTime";
       
      
      public var video:Video;
      
      private var _nsStream:NetStream;
      
      private var _ncConnection:NetConnection;
      
      private var _subtitleTotalTracks:int = -1;
      
      private var _audioTotalTracks:int = -1;
      
      private var _source:String = "";
      
      private var _status:uint;
      
      private var _volume:Number = 0;
      
      private var _metaData:Object;
      
      private var _currentSubtitle:String = "";
      
      private var _subtitleTrack:int = 0;
      
      private var _audioTrack:int = 0;
      
      private var _maxAttemptsCount:int = 1;
      
      private var _curAttempt:int = 0;
      
      private var _bufferTime:Number = 0.1;
      
      private var _isLoop:Boolean = false;
      
      public function SimpleVideoPlayer()
      {
         this._status = PlayerStatus.STOP;
         super();
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer()");
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer | _ncConnection = new NetConnection()");
         this._ncConnection = new NetConnection();
         this._ncConnection.addEventListener(NetStatusEvent.NET_STATUS,this.onNetStatusHandler,false,0,true);
         this._ncConnection.connect(null);
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer | _nsStream = new NetStream(_ncConnection)");
         this._nsStream = new NetStream(this._ncConnection);
         this._nsStream.addEventListener(NetStatusEvent.NET_STATUS,this.onNetStatusHandler,false,0,true);
         this._nsStream.client = {
            "onMetaData":this.onMetaDataHandler,
            "onSubtitle":this.onSubtitleHandler
         };
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer | _nsStream.bufferTime = " + this._bufferTime);
         this._nsStream.bufferTime = this._bufferTime;
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer | video.attachNetStream(_nsStream)");
         this.video.attachNetStream(this._nsStream);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(VIDEO_SOURCE_INVALID))
         {
            this.applyVideoLoading();
         }
         if(isInvalid(SOUND_LEVEL_INVALID))
         {
            if(this._nsStream)
            {
               DebugUtils.LOG_DEBUG("SimpleVideoPlayer | draw() set SOUND_LEVEL_INVALID");
               this._nsStream.soundTransform = new SoundTransform(this._volume);
            }
         }
         if(isInvalid(SELECTED_SUBTITLE_TRACK_INVALID))
         {
            if(this._nsStream.hasOwnProperty(SUBTITLE_TRACK_PROP_NAME))
            {
               DebugUtils.LOG_DEBUG("SimpleVideoPlayer | draw() set SUBTITLE_TRACK_PROP_NAME");
               this._nsStream[SUBTITLE_TRACK_PROP_NAME] = this._subtitleTotalTracks >= this._subtitleTrack ? this._subtitleTrack : 0;
            }
         }
         if(isInvalid(SELECTED_AUDIO_TRACK_INVALID))
         {
            if(this._nsStream.hasOwnProperty(AUDIO_TRACK_PROP_NAME))
            {
               DebugUtils.LOG_DEBUG("SimpleVideoPlayer | draw() set AUDIO_TRACK_PROP_NAME");
               this._nsStream[AUDIO_TRACK_PROP_NAME] = this._audioTotalTracks > this._audioTrack ? this._audioTrack : 0;
            }
         }
         if(isInvalid(INV_BUFFER_TIME))
         {
            DebugUtils.LOG_DEBUG("SimpleVideoPlayer | draw() _nsStream.bufferTime = " + this._bufferTime);
            this._nsStream.bufferTime = this._bufferTime;
         }
      }
      
      override protected function onDispose() : void
      {
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer | onDispose()");
         App.utils.scheduler.cancelTask(invalidate);
         if(this._ncConnection)
         {
            this._ncConnection.removeEventListener(NetStatusEvent.NET_STATUS,this.onNetStatusHandler);
            this._ncConnection = null;
         }
         if(this._nsStream)
         {
            this._nsStream.removeEventListener(NetStatusEvent.NET_STATUS,this.onNetStatusHandler);
            this._nsStream.close();
            this._nsStream = null;
         }
         if(this.video)
         {
            this.video.clear();
            if(this.video.parent)
            {
               this.video.parent.removeChild(this.video);
            }
            this.video = null;
         }
         this._metaData = null;
         super.onDispose();
      }
      
      public function pausePlayback() : void
      {
         if(this._status == PlayerStatus.PLAYING)
         {
            this.setPause();
         }
      }
      
      public function resumePlayback() : void
      {
         if(this._status == PlayerStatus.PAUSE)
         {
            this.setPlay();
         }
      }
      
      public function runPlayback() : void
      {
         this._curAttempt = 0;
         invalidate(VIDEO_SOURCE_INVALID);
      }
      
      public function seek(param1:Number) : void
      {
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer | seek(" + param1 + ")");
         dispatchEvent(new Event(VideoPlayerEvent.SEEK_START));
         this._nsStream.seek(param1);
      }
      
      public function stopPlayback() : void
      {
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer | stopPlayback()");
         this._nsStream.close();
      }
      
      public function togglePlayback() : void
      {
         if(this._status == PlayerStatus.PLAYING)
         {
            this.setPause();
         }
         else if(this._status == PlayerStatus.PAUSE)
         {
            this.setPlay();
         }
      }
      
      protected function setStatus(param1:uint) : void
      {
         if(this._status != param1)
         {
            this._status = param1;
            dispatchEvent(new VideoPlayerStatusEvent(VideoPlayerStatusEvent.STATUS_CHANGED));
         }
      }
      
      private function applyVideoLoading() : void
      {
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer | applyVideoLoading() _source = " + this._source);
         if(this._source != null && this._source != "")
         {
            this.setStatus(PlayerStatus.LOADING);
            this.setSubtitle("");
            this._nsStream.play(this._source);
            invalidate(SOUND_LEVEL_INVALID);
         }
      }
      
      private function onMetaDataHandler(param1:Object) : void
      {
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer | onMetaDataHandler() _metaData = " + param1);
         this._metaData = param1;
         if(this._nsStream.hasOwnProperty(SUBTITLE_TRACK_PROP_NAME))
         {
            this._subtitleTotalTracks = param1.subtitleTracksCount;
            invalidate(SELECTED_SUBTITLE_TRACK_INVALID);
         }
         if(this._nsStream.hasOwnProperty(AUDIO_TRACK_PROP_NAME))
         {
            this._audioTotalTracks = param1.audioTracksCount;
            invalidate(SELECTED_AUDIO_TRACK_INVALID);
         }
         dispatchEvent(new Event(VideoPlayerEvent.META_DATA_CHANGED));
      }
      
      private function onSubtitleHandler(param1:String) : void
      {
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer | onSubtitleHandler() subTitle = " + param1);
         this.setSubtitle(param1);
      }
      
      private function setSubtitle(param1:String) : void
      {
         this._currentSubtitle = param1;
         dispatchEvent(new Event(VideoPlayerEvent.SUBTITLE_CHANGED));
      }
      
      private function onPlaybackStopped() : void
      {
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer | onPlaybackStopped() _isLoop = " + this._isLoop);
         if(this._isLoop)
         {
            this.seek(0);
            this.setStatus(PlayerStatus.PLAYING);
         }
         else
         {
            if(this._status == PlayerStatus.PLAYING || this._status == PlayerStatus.PAUSE)
            {
               this.setStatus(PlayerStatus.STOP);
            }
            dispatchEvent(new VideoPlayerEvent(VideoPlayerEvent.PLAYBACK_STOPPED));
         }
      }
      
      private function setPause() : void
      {
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer | setPause()");
         this._nsStream.pause();
         this.setStatus(PlayerStatus.PAUSE);
      }
      
      private function setPlay() : void
      {
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer | setPlay()");
         this._nsStream.resume();
         this.setStatus(PlayerStatus.PLAYING);
      }
      
      private function tryingToReload() : Boolean
      {
         if(this._curAttempt >= this._maxAttemptsCount)
         {
            return false;
         }
         ++this._curAttempt;
         DebugUtils.LOG_WARNING("Trying to reload " + this._source);
         invalidate(VIDEO_SOURCE_INVALID);
         return true;
      }
      
      [Inspectable(defaultValue="",type="String")]
      public function get source() : String
      {
         return this._source;
      }
      
      public function set source(param1:String) : void
      {
         if(this._source != param1)
         {
            DebugUtils.LOG_DEBUG("SimpleVideoPlayer | set source = " + param1);
            this._curAttempt = 0;
            this._source = param1;
            invalidate(VIDEO_SOURCE_INVALID);
         }
      }
      
      public function get status() : uint
      {
         return this._status;
      }
      
      public function get volume() : Number
      {
         return this._volume;
      }
      
      public function set volume(param1:Number) : void
      {
         if(this._volume != param1)
         {
            DebugUtils.LOG_DEBUG("SimpleVideoPlayer | set volume = " + param1);
            this._volume = param1;
            invalidate(SOUND_LEVEL_INVALID);
            dispatchEvent(new Event(VideoPlayerEvent.VOLUME_CHANGED));
         }
      }
      
      public function get isLoop() : Boolean
      {
         return this._isLoop;
      }
      
      public function set isLoop(param1:Boolean) : void
      {
         if(this._isLoop != param1)
         {
            this._isLoop = param1;
         }
      }
      
      public function get metaData() : Object
      {
         return this._metaData;
      }
      
      public function get currentSubtitle() : String
      {
         return this._currentSubtitle;
      }
      
      [Inspectable(defaultValue="0",type="Number")]
      public function get subtitleTrack() : Number
      {
         return this._subtitleTrack;
      }
      
      public function set subtitleTrack(param1:Number) : void
      {
         this._subtitleTrack = param1;
         invalidate(SELECTED_SUBTITLE_TRACK_INVALID);
      }
      
      [Inspectable(defaultValue="0",type="Number")]
      public function get audioTrack() : Number
      {
         return this._audioTrack;
      }
      
      public function set audioTrack(param1:Number) : void
      {
         this._audioTrack = param1;
         invalidate(SELECTED_AUDIO_TRACK_INVALID);
      }
      
      public function get bufferTime() : Number
      {
         return this._bufferTime;
      }
      
      public function set bufferTime(param1:Number) : void
      {
         this._bufferTime = param1;
         invalidate(INV_BUFFER_TIME);
      }
      
      public function get currentTime() : Number
      {
         if(this._nsStream)
         {
            return this._nsStream.time;
         }
         return NaN;
      }
      
      public function get maxAttemptsCount() : int
      {
         return this._maxAttemptsCount;
      }
      
      public function set maxAttemptsCount(param1:int) : void
      {
         if(this._maxAttemptsCount == param1)
         {
            return;
         }
         this._maxAttemptsCount = param1;
      }
      
      private function onNetStatusHandler(param1:NetStatusEvent) : void
      {
         var _loc4_:VideoPlayerStatusEvent = null;
         var _loc2_:Object = param1.info;
         var _loc3_:String = _loc2_.code;
         DebugUtils.LOG_DEBUG("SimpleVideoPlayer | onNetStatusHandler() streamStatus: " + _loc3_);
         switch(_loc3_)
         {
            case NetStreamStatusCode.START:
               this.setStatus(PlayerStatus.PLAYING);
               App.utils.scheduler.scheduleOnNextFrame(invalidate,SOUND_LEVEL_INVALID);
               break;
            case NetStreamStatusCode.SEEK_NOTIFY:
               dispatchEvent(new Event(VideoPlayerEvent.SEEK_COMPLETE));
               break;
            case NetStreamStatusCode.STOP:
               this.onPlaybackStopped();
               break;
            default:
               if(_loc2_.level == NetStreamStatusLevel.ERROR)
               {
                  this.setStatus(PlayerStatus.STOP);
                  if(!this.tryingToReload())
                  {
                     _loc4_ = new VideoPlayerStatusEvent(VideoPlayerStatusEvent.ERROR);
                     _loc4_.errorCode = _loc3_;
                     dispatchEvent(_loc4_);
                  }
               }
         }
      }
   }
}
