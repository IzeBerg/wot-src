package net.wg.gui.components.dogtag
{
   import fl.motion.easing.Cubic;
   import flash.display.MovieClip;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IFramesHelper;
   import scaleform.clik.motion.Tween;
   
   public class DogtagComponent extends UIComponentEx
   {
      
      public static const FADE_ANIMATION_TIME:int = 250;
      
      public static const DOGTAG_LABEL_ANIMATE:String = "animate";
      
      public static const DOGTAG_LABEL_END_FULL:String = "end_full";
      
      public static const DOGTAG_LABEL_FLAMES:String = "flames";
      
      public static const DOGTAG_LABEL_END_TOP:String = "end_top";
      
      public static const DOGTAG_LABEL_ANIMATE_HIDE:String = "animate_hide";
       
      
      public var dogtagUp:DogtagUpPlate = null;
      
      public var dogtagDown:DogtagDownPlate = null;
      
      public var flames:MovieClip = null;
      
      private var _dogtagFrameHelper:IFramesHelper = null;
      
      private var _fadeIn:Tween = null;
      
      private var _fadeOut:Tween = null;
      
      private var _fadeInFlames:Tween = null;
      
      private var _currentLabel:String = "";
      
      private var _isEngravingMaxLevel:Boolean = false;
      
      public function DogtagComponent()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this._dogtagFrameHelper = new FrameHelper(this);
         this.addAnimationCallback(DOGTAG_LABEL_FLAMES,this.onFlamesPlay);
         this.addAnimationCallback(DOGTAG_LABEL_ANIMATE_HIDE,this.onAnimateHideStart);
      }
      
      private function onAnimateHideStart() : void
      {
         dispatchEvent(new DogTagEvent(DogTagEvent.ON_DOGTAG_COMPONENT_ANIMATE_HIDE_START));
      }
      
      public function addAnimationCallback(param1:String, param2:Function) : void
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
      
      public function animate() : void
      {
         gotoAndPlay(DOGTAG_LABEL_ANIMATE);
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
      
      public function setDogTagInfo(param1:DogTagVO) : void
      {
         this._isEngravingMaxLevel = param1.isEngravingMaxLevel;
         this.dogtagUp.setDogTagInfo(param1.playerName,param1.clanTag,param1.background.imageStr,param1.engraving.imageStr);
         if(this.flames)
         {
            this.setFlamesPlay(this._isEngravingMaxLevel);
         }
         if(this._currentLabel == DOGTAG_LABEL_END_TOP)
         {
            return;
         }
         this.dogtagDown.setDogTagInfo(param1.engraving.name,param1.engraving.value);
      }
      
      public function animateDogTagUpBlink() : void
      {
         this.dogtagUp.animateBlink();
      }
      
      override protected function onDispose() : void
      {
         if(this._dogtagFrameHelper)
         {
            this._dogtagFrameHelper.dispose();
            this._dogtagFrameHelper = null;
         }
         this.dogtagUp.dispose();
         this.dogtagUp = null;
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
         if(this._fadeInFlames)
         {
            this._fadeInFlames.paused = true;
            this._fadeInFlames.dispose();
            this._fadeInFlames = null;
         }
         super.onDispose();
      }
   }
}
