package net.wg.gui.components.dogtag
{
   import fl.motion.easing.Cubic;
   import flash.display.MovieClip;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IFramesHelper;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class DogtagComponent extends UIComponentEx
   {
      
      private static const FADE_ANIMATION_TIME:int = 250;
      
      private static const DOGTAG_COMPONENT_WIDTH:int = 200;
      
      private static const DOGTAG_COMPONENT_HEIGHT:int = 120;
      
      public static const DOGTAG_LABEL_ANIMATE:String = "animate";
      
      public static const DOGTAG_LABEL_ANIMATE_ADV:String = "animate_adv";
      
      public static const DOGTAG_LABEL_END_FULL:String = "end_full";
      
      public static const DOGTAG_LABEL_FLAMES:String = "flames";
      
      public static const DOGTAG_LABEL_END_TOP:String = "end_top";
      
      public static const DOGTAG_LABEL_ANIMATE_HIDE:String = "animate_hide";
      
      public static const DOGTAG_LABEL_ANIMATE_ADV_HIDE:String = "animate_adv_hide";
      
      public static const DOGTAG_LABEL_ANIMATE_ADV_HIDE_END:String = "animate_adv_hide_end";
      
      public static const DOGTAG_LABEL_ANIMATE_ADV_SHOW_END:String = "animate_adv_end";
       
      
      public var animationContainer:MovieClip = null;
      
      public var dogtagUp:DogtagUpPlate = null;
      
      public var dogtagDown:DogtagDownPlate = null;
      
      public var flames:MovieClip = null;
      
      private var _dogtagFrameHelper:IFramesHelper = null;
      
      private var _fadeIn:Tween = null;
      
      private var _fadeOut:Tween = null;
      
      private var _currentLabel:String = "";
      
      private var _isEngravingMaxLevel:Boolean = false;
      
      private var _animationPath:String;
      
      private var _animation:UILoaderAlt;
      
      public function DogtagComponent()
      {
         this._animationPath = String.prototype;
         this._animation = new UILoaderAlt();
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.animationContainer.addChild(this._animation);
         this._dogtagFrameHelper = new FrameHelper(this);
         this.addAnimationCallback(DOGTAG_LABEL_FLAMES,this.onFlamesPlay);
         this.addAnimationCallback(DOGTAG_LABEL_ANIMATE_HIDE,this.onAnimateHideStart);
         this.addAnimationCallback(DOGTAG_LABEL_END_FULL,this.onAnimateShowEnd);
         this.addAnimationCallback(DOGTAG_LABEL_ANIMATE_ADV_HIDE,this.onAnimateHideStart);
         this.addAnimationCallback(DOGTAG_LABEL_ANIMATE_ADV_HIDE_END,this.onAnimateAdvHideEnd);
         this.addAnimationCallback(DOGTAG_LABEL_ANIMATE_ADV_SHOW_END,this.onAnimateShowEnd);
      }
      
      private function onAnimateShowEnd() : void
      {
         dispatchEvent(new DogTagEvent(DogTagEvent.ON_DOGTAG_COMPONENT_ANIMATE_SHOW_END));
      }
      
      private function onAnimateHideStart() : void
      {
         dispatchEvent(new DogTagEvent(DogTagEvent.ON_DOGTAG_COMPONENT_ANIMATE_HIDE_START));
      }
      
      override protected function onDispose() : void
      {
         stop();
         this._dogtagFrameHelper.dispose();
         this._dogtagFrameHelper = null;
         this.dogtagUp.dispose();
         this.dogtagUp = null;
         this.animationContainer.removeChild(this._animation);
         this.animationContainer = null;
         this._animation.unload();
         this._animation.dispose();
         this._animation = null;
         if(this.flames)
         {
            this.flames.stop();
            this.flames = null;
         }
         if(this.dogtagDown)
         {
            this.dogtagDown.dispose();
            this.dogtagDown = null;
         }
         if(this._fadeIn)
         {
            this._fadeIn.paused = true;
            this._fadeIn.dispose();
            this._fadeIn = null;
         }
         if(this._fadeOut)
         {
            this._fadeOut.paused = true;
            this._fadeOut.dispose();
            this._fadeOut = null;
         }
         super.onDispose();
      }
      
      public function animate() : void
      {
         this._animation.unload();
         if(this._animationPath)
         {
            this._animation.source = this._animationPath;
            gotoAndPlay(DOGTAG_LABEL_ANIMATE_ADV);
         }
         else
         {
            gotoAndPlay(DOGTAG_LABEL_ANIMATE);
         }
      }
      
      public function animateHide() : void
      {
         gotoAndPlay(Boolean(this._animationPath) ? DOGTAG_LABEL_ANIMATE_ADV_HIDE : DOGTAG_LABEL_ANIMATE_HIDE);
      }
      
      public function goToLabel(param1:String) : void
      {
         gotoAndStop(param1);
         this._currentLabel = param1;
      }
      
      public function fadeIn() : void
      {
         this.alpha = 0;
         if(this._fadeIn)
         {
            this._fadeIn.paused = true;
         }
         if(this._fadeOut)
         {
            this._fadeOut.paused = true;
         }
         this._fadeIn = new Tween(250,this,{"alpha":1},{
            "paused":false,
            "ease":Cubic.easeOut
         });
         this.dogtagDown.invalidateSize();
      }
      
      public function fadeOut(param1:Function = null) : void
      {
         if(this._fadeIn)
         {
            this._fadeIn.paused = true;
         }
         if(this._fadeOut)
         {
            this._fadeOut.paused = true;
         }
         this._fadeOut = new Tween(FADE_ANIMATION_TIME,this,{"alpha":0},{
            "paused":false,
            "ease":Cubic.easeOut
         });
         if(param1 != null)
         {
            this._fadeOut.onComplete = param1;
         }
      }
      
      public function hideNameAndClan() : void
      {
         this.dogtagUp.playerName.visible = false;
         this.dogtagUp.clan.visible = false;
      }
      
      public function setDogTagInfo(param1:DogTagVO) : void
      {
         this._isEngravingMaxLevel = param1.isEngravingMaxLevel;
         this._animationPath = param1.animationSrc;
         this.dogtagUp.setDogTagInfo(param1.playerName,param1.clanTag,param1.background.imageStr,param1.engraving.imageStr,StringUtils.isNotEmpty(param1.animationSrc));
         if(this.flames)
         {
            this.setFlamesPlay(this._isEngravingMaxLevel);
         }
         if(this._currentLabel == DOGTAG_LABEL_END_TOP)
         {
            return;
         }
         this.dogtagDown.setDogTagInfo(param1.engraving.name,param1.engraving.value,param1.bottomPlateSrc,StringUtils.isNotEmpty(param1.animationSrc));
      }
      
      public function animateDogTagUpBlink() : void
      {
         this.dogtagUp.animateBlink();
      }
      
      override public function get width() : Number
      {
         return DOGTAG_COMPONENT_WIDTH;
      }
      
      override public function get height() : Number
      {
         return DOGTAG_COMPONENT_HEIGHT;
      }
      
      private function onFlamesPlay() : void
      {
         this.setFlamesPlay(this._isEngravingMaxLevel);
      }
      
      private function setFlamesPlay(param1:Boolean) : void
      {
         if(param1)
         {
            this.flames.visible = true;
            this.flames.gotoAndPlay("play");
         }
         else
         {
            this.flames.visible = false;
            this.flames.stop();
         }
      }
      
      private function onAnimateAdvHideEnd() : void
      {
         this._animation.unload();
      }
      
      private function addAnimationCallback(param1:String, param2:Function) : void
      {
         var _loc3_:int = 0;
         if(param2 == null)
         {
            DebugUtils.LOG_WARNING(Errors.CANT_NULL);
         }
         else
         {
            _loc3_ = this._dogtagFrameHelper.getFrameByLabel(param1);
            if(_loc3_ != FrameHelper.NOT_EXIST_INDEX)
            {
               this._dogtagFrameHelper.addScriptToFrame(_loc3_,param2);
            }
         }
      }
   }
}
