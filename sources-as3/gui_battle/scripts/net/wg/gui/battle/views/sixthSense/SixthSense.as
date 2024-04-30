package net.wg.gui.battle.views.sixthSense
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.data.constants.generated.SIXTHSENSEINDICATOR_CONSTS;
   import net.wg.gui.components.common.AlphaPropertyWrapper;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.base.meta.ISixthSenseMeta;
   import net.wg.infrastructure.base.meta.impl.SixthSenseMeta;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.motion.Tween;
   
   public class SixthSense extends SixthSenseMeta implements ISixthSenseMeta
   {
      
      public static const EVENT_CHANGE_VISIBILITY:String = "SixthSense_EVENT_CHANGE_VISIBILITY";
      
      public static const EVENT_POSITION_CHANGED:String = "SixthSense_EVENT_POSITION_CHANGED";
      
      public static const HALF_HEIGHT:int = 43;
      
      private static const OFFSET_X:int = -109;
      
      private static const OFFSET_Y:int = -225;
      
      private static const OFFSET_X_2K_4K_x1:int = -150;
      
      private static const OFFSET_Y_2K_4K_x1:int = -275;
      
      private static const ALPHA_TWEEN_DURATION:uint = 200;
      
      private static const LABEL_SHOW_ALARM:String = "showAlarm";
      
      private static const LABEL_SHOW_INDICATOR:String = "showIndicator";
      
      private static const LABEL_IDLE:String = "idle";
      
      private static const LABEL_HIDE:String = "hide";
      
      private static const LABEL_HIDDEN:String = "hidden";
      
      private static const PERSENT_TO_ALPHA:Number = 0.01;
      
      private static const INDICATOR_ALPHA:uint = 1;
       
      
      public var lamp:MovieClip = null;
      
      private var _frameHelper:FrameHelper = null;
      
      private var _size:String = "big";
      
      private var _alpha:uint = 100;
      
      private var _alphaTween:Tween = null;
      
      private var _alphaWrapper:AlphaPropertyWrapper = null;
      
      private var _stageW:int = 0;
      
      private var _stageH:int = 0;
      
      public function SixthSense()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
         this.visible = false;
         this._alphaWrapper = new AlphaPropertyWrapper(this);
         this._frameHelper = new FrameHelper(this);
         this._frameHelper.addScriptToFrame(this.totalFrames - 1,this.onIndicatorHiddenHandler);
      }
      
      override protected function onDispose() : void
      {
         if(this._alphaTween)
         {
            this._alphaTween.dispose();
            this._alphaTween = null;
         }
         this._alphaWrapper.dispose();
         this._alphaWrapper = null;
         this._frameHelper.dispose();
         this._frameHelper = null;
         this.lamp = null;
         super.onDispose();
      }
      
      public function as_hide(param1:Boolean) : void
      {
         if(!visible)
         {
            return;
         }
         if(param1)
         {
            this.onIndicatorHiddenHandler();
         }
         else
         {
            gotoAndPlay(LABEL_HIDE);
            this.validate();
         }
      }
      
      public function as_setAlpha(param1:uint) : void
      {
         if(param1 == this._alpha)
         {
            return;
         }
         this._alpha = Math.max(SIXTHSENSEINDICATOR_CONSTS.MIN_VALUE,param1);
         this.applyAlpha();
      }
      
      public function as_setIsBig(param1:Boolean) : void
      {
         this._size = !!param1 ? SIXTHSENSEINDICATOR_CONSTS.SIZE_BIG : SIXTHSENSEINDICATOR_CONSTS.SIZE_SMALL;
         this.applySize();
      }
      
      public function as_show(param1:Boolean) : void
      {
         this.visible = true;
         if(param1)
         {
            gotoAndPlay(LABEL_IDLE);
         }
         else
         {
            gotoAndPlay(LABEL_SHOW_ALARM);
         }
         this.validate();
      }
      
      public function as_showIndicator() : void
      {
         this.visible = true;
         gotoAndPlay(LABEL_SHOW_INDICATOR);
         this.validate();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         if(param1 != this._stageW || param2 != this._stageH)
         {
            this._stageW = param1;
            this._stageH = param2;
            this.applyPosition();
         }
      }
      
      private function applyPosition() : void
      {
         var _loc1_:int = this._stageH >> 1;
         var _loc2_:int = this._stageW >> 1;
         var _loc3_:Number = App.appScale;
         if(this._stageH >= StageSizeBoundaries.HEIGHT_1600 && _loc3_ == 1)
         {
            x = _loc2_ + OFFSET_X_2K_4K_x1;
            y = _loc1_ + OFFSET_Y_2K_4K_x1;
         }
         else
         {
            x = _loc2_ + OFFSET_X;
            y = _loc1_ + OFFSET_Y;
         }
         dispatchEvent(new Event(EVENT_POSITION_CHANGED));
      }
      
      private function applyAlpha() : void
      {
         var _loc1_:Number = currentLabel == LABEL_SHOW_ALARM ? Number(INDICATOR_ALPHA) : Number(this._alpha * PERSENT_TO_ALPHA);
         if(currentLabel == LABEL_SHOW_ALARM || alpha != _loc1_)
         {
            if(this._alphaTween)
            {
               this._alphaTween.dispose();
            }
            this._alphaTween = new Tween(ALPHA_TWEEN_DURATION,this._alphaWrapper,{"alpha":_loc1_});
         }
      }
      
      private function applySize() : void
      {
         if(currentLabel != LABEL_SHOW_ALARM)
         {
            this.lamp.gotoAndStop(this._size);
         }
         else
         {
            this.lamp.gotoAndStop(SIXTHSENSEINDICATOR_CONSTS.SIZE_BIG);
         }
      }
      
      private function validate() : void
      {
         this.applyAlpha();
         this.applySize();
         this.applyPosition();
      }
      
      private function onIndicatorHiddenHandler() : void
      {
         gotoAndStop(LABEL_HIDDEN);
         this.visible = false;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(super.visible != param1)
         {
            super.visible = param1;
            dispatchEvent(new Event(EVENT_CHANGE_VISIBILITY));
         }
      }
   }
}
