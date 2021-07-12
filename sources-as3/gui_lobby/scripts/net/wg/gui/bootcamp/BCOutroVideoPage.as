package net.wg.gui.bootcamp
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.common.video.SimpleVideoPlayer;
   import net.wg.gui.components.common.video.VideoPlayerEvent;
   import net.wg.gui.components.common.video.VideoPlayerStatusEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.meta.IBCOutroVideoPageMeta;
   import net.wg.infrastructure.base.meta.impl.BCOutroVideoPageMeta;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.FocusManager;
   
   public class BCOutroVideoPage extends BCOutroVideoPageMeta implements IBCOutroVideoPageMeta
   {
      
      private static const INTRO_INFO_CHANGED:String = "infoChanged";
      
      private static const STAGE_RESIZED:String = "stageResized";
      
      private static const SKIP_BTN_Y:int = -88;
       
      
      public var videoPlayer:SimpleVideoPlayer;
      
      public var blackBG:MovieClip;
      
      public var btnSkipVideo:SoundButtonEx;
      
      private var _introInfo:BCOutroVideoVO;
      
      private var _playerOriginalWidth:Number;
      
      private var _playerOriginalHeight:Number;
      
      private var _playerOriginalScaleX:Number;
      
      private var _playerOriginalScaleY:Number;
      
      private var _stageDimensions:Point;
      
      private var _skipShown:Boolean = false;
      
      public function BCOutroVideoPage()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         if(this._stageDimensions == null)
         {
            this._stageDimensions = new Point();
         }
         this._stageDimensions.x = param1;
         this._stageDimensions.y = param2;
         invalidate(STAGE_RESIZED);
      }
      
      public function as_pausePlayback() : void
      {
         this.videoPlayer.pausePlayback();
      }
      
      public function as_resumePlayback() : void
      {
         this.videoPlayer.resumePlayback();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._playerOriginalWidth = this.videoPlayer.width;
         this._playerOriginalHeight = this.videoPlayer.height;
         this._playerOriginalScaleX = this.videoPlayer.scaleX;
         this._playerOriginalScaleY = this.videoPlayer.scaleY;
         this.videoPlayer.addEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.onVideoPlayerPlaybackStoppedHandler);
         this.videoPlayer.addEventListener(VideoPlayerStatusEvent.ERROR,this.onVideoPlayerErrorHandler);
         this.btnSkipVideo.label = BOOTCAMP.BTN_SKIPVIDEO;
         this.btnSkipVideo.addEventListener(ButtonEvent.CLICK,this.onSkipVideoButtonClickHandler);
         this.btnSkipVideo.visible = false;
         App.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         App.stage.addEventListener(MouseEvent.CLICK,this.onStageClickHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         super.draw();
         if(this._introInfo && isInvalid(INTRO_INFO_CHANGED))
         {
            if(StringUtils.isNotEmpty(this._introInfo.source))
            {
               this.videoPlayer.volume = this._introInfo.volume;
               this.videoPlayer.source = this._introInfo.source;
               if(this._introInfo.bufferTime != Values.DEFAULT_INT)
               {
                  this.videoPlayer.bufferTime = this._introInfo.bufferTime;
               }
            }
            else
            {
               videoFinishedS();
            }
         }
         if(this._stageDimensions != null && isInvalid(STAGE_RESIZED,INTRO_INFO_CHANGED))
         {
            _loc2_ = this._stageDimensions.x / this._stageDimensions.y > this._playerOriginalWidth / this._playerOriginalHeight;
            _loc3_ = this._introInfo != null ? Boolean(this._introInfo.fitToScreen) : Boolean(false);
            if(_loc3_)
            {
               _loc2_ = !_loc2_;
            }
            if(_loc2_)
            {
               _loc1_ = this._stageDimensions.x / this._playerOriginalWidth;
            }
            else
            {
               _loc1_ = this._stageDimensions.y / this._playerOriginalHeight;
            }
            this.videoPlayer.scaleX = this._playerOriginalScaleX * _loc1_;
            this.videoPlayer.scaleY = this._playerOriginalScaleY * _loc1_;
            this.videoPlayer.x = this._stageDimensions.x - this.videoPlayer.width >> 1;
            this.videoPlayer.y = this._stageDimensions.y - this.videoPlayer.height >> 1;
            this.blackBG.width = this._stageDimensions.x;
            this.blackBG.height = this._stageDimensions.y;
            this.btnSkipVideo.x = this._stageDimensions.x - this.btnSkipVideo.width >> 1;
            this.btnSkipVideo.y = this._stageDimensions.y + SKIP_BTN_Y;
         }
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(MouseEvent.CLICK,this.onStageClickHandler);
         App.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         this.videoPlayer.removeEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.onVideoPlayerPlaybackStoppedHandler);
         this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.ERROR,this.onVideoPlayerErrorHandler);
         this.videoPlayer.dispose();
         this.videoPlayer = null;
         this.btnSkipVideo.removeEventListener(ButtonEvent.CLICK,this.onSkipVideoButtonClickHandler);
         this.btnSkipVideo.dispose();
         this.btnSkipVideo = null;
         this.blackBG = null;
         this._stageDimensions = null;
         this._introInfo.dispose();
         this._introInfo = null;
         super.onDispose();
      }
      
      override protected function playVideo(param1:BCOutroVideoVO) : void
      {
         this._introInfo = param1;
         invalidate(INTRO_INFO_CHANGED);
      }
      
      private function onKeyDownHandler(param1:Event) : void
      {
         if(!this._skipShown)
         {
            this.showSkip();
         }
      }
      
      private function showSkip() : void
      {
         this._skipShown = true;
         this.btnSkipVideo.visible = true;
         FocusManager.setFocus(this.btnSkipVideo);
      }
      
      private function onSkipVideoButtonClickHandler(param1:ButtonEvent) : void
      {
         videoFinishedS();
      }
      
      private function onVideoPlayerPlaybackStoppedHandler(param1:VideoPlayerEvent) : void
      {
         videoFinishedS();
      }
      
      private function onVideoPlayerErrorHandler(param1:VideoPlayerStatusEvent) : void
      {
         handleErrorS(param1.errorCode);
      }
      
      private function onStageClickHandler(param1:MouseEvent) : void
      {
         if(!this._skipShown)
         {
            this.showSkip();
         }
      }
   }
}
