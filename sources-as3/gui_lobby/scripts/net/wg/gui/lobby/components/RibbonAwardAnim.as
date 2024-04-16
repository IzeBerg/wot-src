package net.wg.gui.lobby.components
{
   import flash.display.FrameLabel;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.gui.lobby.components.events.RibbonAwardAnimEvent;
   import net.wg.gui.lobby.components.interfaces.IRibbonAwardAnim;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class RibbonAwardAnim extends UIComponentEx implements IRibbonAwardAnim
   {
      
      private static const BLINK_LABEL:String = "blink";
      
      private static const BLINK_HALF_COMPLETE_LABEL:String = "blinkHalfComplete";
      
      private static const BLINK_COMPLETE_LABEL:String = "blinkComplete";
      
      private static const FADE_IN_LABEL:String = "fadeIn";
      
      private static const FADE_IN_COMPLETE_LABEL:String = "fadeInComplete";
      
      private static const FADE_OUT_LABEL:String = "fadeOut";
      
      private static const FADE_OUT_COMPLETE_LABEL:String = "fadeOutComplete";
      
      protected static const CREDITS:String = "credits";
      
      protected static const GOLD:String = "gold";
      
      protected static const CRYSTAL:String = "crystal";
      
      protected static const CREDITS_FACTOR:String = "creditsFactor";
      
      private static const Y_BLINK_OFFSET:uint = 15;
       
      
      public var ribbonAward:AwardItemRendererEx = null;
      
      private var _data:AwardItemRendererExVO = null;
      
      private var _frameHelper:FrameHelper = null;
      
      private var _originY:Number;
      
      public function RibbonAwardAnim()
      {
         super();
         this._frameHelper = new FrameHelper(this);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setMouseEnabled(false);
         var _loc1_:Array = currentLabels;
         var _loc2_:int = _loc1_.length;
         var _loc3_:FrameLabel = null;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            if(_loc3_.name == BLINK_HALF_COMPLETE_LABEL)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onBlinkHalfComplete);
            }
            else if(_loc3_.name == BLINK_COMPLETE_LABEL)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onBlinkComplete);
            }
            else if(_loc3_.name == FADE_IN_COMPLETE_LABEL)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onFadeInComplete);
            }
            else if(_loc3_.name == FADE_OUT_COMPLETE_LABEL)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onFadeOutComplete);
            }
            _loc4_++;
         }
      }
      
      override protected function onDispose() : void
      {
         stop();
         App.utils.scheduler.cancelTask(gotoAndPlay);
         App.utils.scheduler.cancelTask(this.onStartFadeIn);
         this.ribbonAward.dispose();
         this.ribbonAward = null;
         this._frameHelper.dispose();
         this._frameHelper = null;
         this._data.dispose();
         this._data = null;
         super.onDispose();
      }
      
      public function blink(param1:Number = 0) : void
      {
         this.setMouseEnabled(false);
         this.playAnim(BLINK_LABEL,param1);
      }
      
      public function fadeIn(param1:Number = 0) : void
      {
         this.playAnim(FADE_IN_LABEL,param1);
         App.utils.scheduler.scheduleTask(this.onStartFadeIn,param1);
      }
      
      public function fadeOut(param1:Number = 0) : void
      {
         this.setMouseEnabled(false);
         this.playAnim(FADE_OUT_LABEL,param1);
      }
      
      public function setRendererData(param1:Object) : void
      {
         this._data = new AwardItemRendererExVO(param1);
         this.ribbonAward.setData(this._data);
      }
      
      private function resetY() : void
      {
         super.y = this._originY;
      }
      
      private function playAnim(param1:String, param2:Number = 0) : void
      {
         if(param2 > 0)
         {
            App.utils.scheduler.scheduleTask(gotoAndPlay,param2,param1);
         }
         else
         {
            gotoAndPlay(param1);
         }
      }
      
      private function setMouseEnabled(param1:Boolean) : void
      {
         mouseEnabled = mouseChildren = param1;
      }
      
      private function onBlinkHalfComplete() : void
      {
         super.y = this._originY + Y_BLINK_OFFSET;
      }
      
      private function onBlinkComplete() : void
      {
         this.setMouseEnabled(true);
         dispatchEvent(new RibbonAwardAnimEvent(RibbonAwardAnimEvent.AWARD_BLINK_COMPLETE));
      }
      
      private function onFadeInComplete() : void
      {
         this.setMouseEnabled(true);
         dispatchEvent(new RibbonAwardAnimEvent(RibbonAwardAnimEvent.AWARD_FADE_IN_COMPLETE));
      }
      
      private function onFadeOutComplete() : void
      {
         this.resetY();
         dispatchEvent(new RibbonAwardAnimEvent(RibbonAwardAnimEvent.AWARD_FADE_OUT_COMPLETE));
      }
      
      private function onStartFadeIn() : void
      {
         switch(this._data.itemName)
         {
            case CREDITS:
            case GOLD:
            case CRYSTAL:
            case CREDITS_FACTOR:
               dispatchEvent(new RibbonAwardAnimEvent(RibbonAwardAnimEvent.MONEY_FADE_IN,true));
               break;
            default:
               dispatchEvent(new RibbonAwardAnimEvent(RibbonAwardAnimEvent.CONSUMABLE_FADE_IN,true));
         }
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
         this._originY = param1;
      }
   }
}
