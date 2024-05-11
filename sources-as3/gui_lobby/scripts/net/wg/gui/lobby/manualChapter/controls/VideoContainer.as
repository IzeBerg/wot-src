package net.wg.gui.lobby.manualChapter.controls
{
   import fl.transitions.easing.Regular;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.manualChapter.data.ManualChapterVideoVO;
   import net.wg.gui.lobby.manualChapter.events.ManualViewEvent;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class VideoContainer extends PageContentTemplate
   {
       
      
      public var preview:UILoaderAlt = null;
      
      public var btnPlay:ISoundButtonEx = null;
      
      private var _tweens:Vector.<Tween>;
      
      private var _vo:ManualChapterVideoVO = null;
      
      private const TWEEN_DURATION:int = 300;
      
      private const PREVIEW_WIDTH:int = 1124;
      
      private const PREVIEW_HEIGHT:int = 600;
      
      public function VideoContainer()
      {
         this._tweens = new Vector.<Tween>(0);
         super();
      }
      
      override public function fadeIn() : void
      {
         this.preview.alpha = 0;
         this._tweens.push(new Tween(this.TWEEN_DURATION,this.preview,{"alpha":1},{
            "paused":false,
            "ease":Regular.easeIn
         }));
         this._tweens.push(new Tween(this.TWEEN_DURATION,this.btnPlay,{"alpha":1},{
            "paused":false,
            "ease":Regular.easeIn
         }));
      }
      
      override public function fadeOut() : void
      {
         this._tweens.push(new Tween(this.TWEEN_DURATION,this.preview,{"alpha":0},{
            "paused":false,
            "ease":Regular.easeIn
         }));
         this._tweens.push(new Tween(this.TWEEN_DURATION,this.btnPlay,{"alpha":0},{
            "paused":false,
            "ease":Regular.easeIn
         }));
      }
      
      override public function isCentered() : Boolean
      {
         return true;
      }
      
      override public function isFullSize() : Boolean
      {
         return true;
      }
      
      override public function isSeparated() : Boolean
      {
         return false;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._vo = ManualChapterVideoVO(getData());
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btnPlay.addEventListener(ButtonEvent.CLICK,this.onBtnPlayClickHandler);
         this.preview.maintainAspectRatio = false;
         this.preview.buttonMode = this.preview.useHandCursor = true;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = getContentScale();
            _width = this.PREVIEW_WIDTH * _loc1_;
            _height = this.PREVIEW_HEIGHT * _loc1_;
            this.preview.setOriginalWidth(_width);
            this.preview.setOriginalHeight(_height);
            this.preview.updateLoaderSize();
            this.preview.x = -_width >> 1;
            this.btnPlay.x = -this.btnPlay.width >> 1;
            this.btnPlay.y = _height >> 1;
         }
         if(this._vo && isInvalid(InvalidationType.DATA))
         {
            this.preview.source = this._vo.previewImage;
         }
      }
      
      override protected function onDispose() : void
      {
         this.btnPlay.removeEventListener(MouseEvent.CLICK,this.onBtnPlayClickHandler);
         this.btnPlay.dispose();
         this.btnPlay = null;
         this.preview.dispose();
         this.preview = null;
         this.disposeTweens();
         this._tweens = null;
         this._vo = null;
         super.onDispose();
      }
      
      override protected function getDataVO(param1:Object) : IDAAPIDataClass
      {
         return new ManualChapterVideoVO(param1);
      }
      
      public function getVideoUrl() : String
      {
         return this._vo.videoUrl;
      }
      
      private function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.splice(0,this._tweens.length);
      }
      
      private function onBtnPlayClickHandler(param1:Event) : void
      {
         dispatchEvent(new ManualViewEvent(ManualViewEvent.PREVIEW_CLICKED,true));
      }
   }
}
