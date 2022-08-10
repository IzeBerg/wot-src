package net.wg.gui.intro
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import net.wg.gui.components.common.video.SimpleVideoPlayer;
   import net.wg.gui.components.common.video.VideoPlayerEvent;
   import net.wg.gui.components.common.video.VideoPlayerStatusEvent;
   import net.wg.infrastructure.base.meta.IIntroPageMeta;
   import net.wg.infrastructure.base.meta.impl.IntroPageMeta;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class IntroPage extends IntroPageMeta implements IIntroPageMeta
   {
      
      private static const STAGE_RESIZED:String = "stageResized";
       
      
      public var videoPlayer:SimpleVideoPlayer;
      
      private var _introInfo:IntroInfoVO;
      
      private var _playerOriginalWidth:Number;
      
      private var _playerOriginalHeight:Number;
      
      private var _stageDimensions:Point;
      
      public function IntroPage()
      {
         super();
         focusable = true;
      }
      
      private static function imitateNoBorderScaleMode(param1:DisplayObject, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         param1.scaleX = param1.scaleY = Math.max(param2 / param4,param3 / param5);
         param1.x = param2 - param1.width >> 1;
         param1.y = param3 - param1.height >> 1;
      }
      
      override public function setViewSize(param1:Number, param2:Number) : void
      {
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         if(!this._stageDimensions)
         {
            this._stageDimensions = new Point();
         }
         this._stageDimensions.x = param1;
         this._stageDimensions.y = param2;
         invalidate(STAGE_RESIZED);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.videoPlayer.addEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.onVideoPlayerPlaybackStoppedHandler,false,0,true);
         this.videoPlayer.addEventListener(VideoPlayerStatusEvent.ERROR,this.onVideoPlayerErrorHandler,false,0,true);
         stage.addEventListener(MouseEvent.CLICK,this.onStageClickHandler,false,0,true);
         this._playerOriginalWidth = this.videoPlayer.width;
         this._playerOriginalHeight = this.videoPlayer.height;
      }
      
      override protected function playVideo(param1:IntroInfoVO) : void
      {
         this.videoPlayer.volume = param1.volume;
         this.videoPlayer.bufferTime = param1.bufferTime;
         this.videoPlayer.source = param1.source;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._stageDimensions && isInvalid(STAGE_RESIZED))
         {
            IntroPage.imitateNoBorderScaleMode(this,this._stageDimensions.x,this._stageDimensions.y,this._playerOriginalWidth,this._playerOriginalHeight);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.videoPlayer)
         {
            this.videoPlayer.removeEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.onVideoPlayerPlaybackStoppedHandler);
            this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.ERROR,this.onVideoPlayerErrorHandler);
            this.videoPlayer.dispose();
            this.videoPlayer = null;
         }
         if(stage)
         {
            stage.removeEventListener(MouseEvent.CLICK,this.onStageClickHandler);
         }
         this._introInfo = null;
         this._stageDimensions = null;
         super.onDispose();
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc2_:InputDetails = null;
         var _loc3_:Number = NaN;
         super.handleInput(param1);
         if(this._introInfo && this._introInfo.canSkip)
         {
            _loc2_ = param1.details;
            if(_loc2_.value == InputValue.KEY_DOWN)
            {
               _loc3_ = _loc2_.code;
               if(_loc3_ == Keyboard.ESCAPE || _loc3_ == Keyboard.ENTER || _loc3_ == Keyboard.SPACE)
               {
                  param1.handled = true;
                  this.videoPlayer.stopPlayback();
               }
            }
         }
      }
      
      private function onStageClickHandler(param1:MouseEvent) : void
      {
         if(this._introInfo && this._introInfo.canSkip)
         {
            this.videoPlayer.stopPlayback();
         }
      }
      
      private function onVideoPlayerPlaybackStoppedHandler(param1:VideoPlayerEvent) : void
      {
         stopVideoS();
      }
      
      private function onVideoPlayerErrorHandler(param1:VideoPlayerStatusEvent) : void
      {
         handleErrorS(param1.errorCode);
      }
   }
}
