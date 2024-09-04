package net.wg.gui.lobby.components
{
   import flash.display.DisplayObject;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.gui.lobby.components.data.RibbonAwardsVO;
   import net.wg.gui.lobby.components.events.RibbonAwardAnimEvent;
   import net.wg.gui.lobby.components.interfaces.IRibbonAwardAnim;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.InvalidationType;
   
   public class RibbonAwards extends UIComponentEx
   {
      
      private static const FADE_IN_LABEL:String = "fadeIn";
      
      private static const FADE_IN_COMPLETE_LABEL:String = "fadeInComplete";
      
      private static const FADE_OUT_LABEL:String = "fadeOut";
      
      private static const FADE_OUT_COMPLETE_LABEL:String = "fadeOutComplete";
      
      private static const FADE_IN_DELAY:uint = 200;
       
      
      public var ribbonAnim:MovieClip = null;
      
      private var _awardItemRenderers:Vector.<IRibbonAwardAnim> = null;
      
      private var _lastAwardItem:IRibbonAwardAnim = null;
      
      private var _data:RibbonAwardsVO = null;
      
      private var _frameHelper:FrameHelper = null;
      
      private var _awardsCount:uint = 0;
      
      public function RibbonAwards()
      {
         super();
         this._awardItemRenderers = new Vector.<IRibbonAwardAnim>();
         this._frameHelper = new FrameHelper(this.ribbonAnim);
         this.ribbonAnim.gotoAndStop(1);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.ribbonAnim.picRibbon.gotoAndStop(this._data.ribbonType);
            this.createAwardItemRenderers();
            this.drawAwardItemRenderers();
         }
      }
      
      override protected function configUI() : void
      {
         var _loc1_:Array = this.ribbonAnim.currentLabels;
         var _loc2_:int = _loc1_.length;
         var _loc3_:FrameLabel = null;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            if(_loc3_.name == FADE_IN_COMPLETE_LABEL)
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
      
      override protected function onBeforeDispose() : void
      {
         this.clear();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         this._frameHelper.dispose();
         this._frameHelper = null;
         this.ribbonAnim.stop();
         this.ribbonAnim = null;
         for each(_loc1_ in this._awardItemRenderers)
         {
            _loc1_.dispose();
         }
         this._awardItemRenderers.splice(0,this._awardItemRenderers.length);
         this._awardItemRenderers = null;
         this._lastAwardItem = null;
         this._data = null;
         super.onDispose();
      }
      
      public function blink() : void
      {
         var _loc1_:uint = this._awardItemRenderers.length;
         var _loc2_:IRibbonAwardAnim = null;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._awardItemRenderers[_loc3_];
            _loc2_.blink();
            _loc3_++;
         }
      }
      
      public function clear() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._awardsCount)
         {
            removeChild(DisplayObject(this._awardItemRenderers[_loc1_]));
            _loc1_++;
         }
         if(this._lastAwardItem)
         {
            this._lastAwardItem.removeEventListener(RibbonAwardAnimEvent.AWARD_FADE_IN_COMPLETE,this.onLastItemAwardFadeInCompleteHandler);
            this._lastAwardItem.removeEventListener(RibbonAwardAnimEvent.AWARD_BLINK_COMPLETE,this.onLastItemAwardBlinkCompleteHandler);
            this._lastAwardItem.removeEventListener(RibbonAwardAnimEvent.AWARD_FADE_OUT_COMPLETE,this.onLastItemAwardFadeOutCompleteHandler);
         }
         this._awardsCount = 0;
      }
      
      public function getAwardsWidth() : Number
      {
         var _loc1_:Number = 0;
         if(this._data)
         {
            _loc1_ = (this._data.gap + this._data.rendererWidth) * this._awardsCount;
         }
         return _loc1_;
      }
      
      public function hide() : void
      {
         this.ribbonAnim.gotoAndPlay(FADE_OUT_LABEL);
         this.fadeOutAwards();
      }
      
      public function isDataNew(param1:RibbonAwardsVO) : Boolean
      {
         return this._data != param1;
      }
      
      public function setData(param1:RibbonAwardsVO) : void
      {
         if(this._data != param1)
         {
            this._data = param1;
            this._awardsCount = this._data.awards.length;
            invalidateData();
         }
      }
      
      public function show() : void
      {
         this.ribbonAnim.gotoAndPlay(FADE_IN_LABEL);
      }
      
      public function updateData(param1:RibbonAwardsVO) : void
      {
         this.setData(param1);
      }
      
      private function fadeInAwards() : void
      {
         if(this._awardsCount == 0)
         {
            this.onLastItemAwardFadeInCompleteHandler(null);
            return;
         }
         var _loc1_:IRibbonAwardAnim = null;
         var _loc2_:uint = this._awardItemRenderers.length <= this._awardsCount ? uint(this._awardItemRenderers.length) : uint(this._awardsCount);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._awardItemRenderers[_loc3_];
            _loc1_.fadeIn(FADE_IN_DELAY * _loc3_);
            _loc3_++;
         }
      }
      
      private function fadeOutAwards() : void
      {
         var _loc1_:IRibbonAwardAnim = null;
         var _loc2_:uint = this._awardItemRenderers.length <= this._awardsCount ? uint(this._awardItemRenderers.length) : uint(this._awardsCount);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._awardItemRenderers[_loc3_];
            _loc1_.fadeOut();
            _loc3_++;
         }
      }
      
      private function createAwardItemRenderers() : void
      {
         var _loc1_:IRibbonAwardAnim = null;
         var _loc2_:IClassFactory = App.utils.classFactory;
         var _loc3_:uint = 0;
         while(_loc3_ < this._awardsCount)
         {
            if(_loc3_ >= this._awardItemRenderers.length)
            {
               _loc1_ = _loc2_.getComponent(this._data.rendererLinkage,IRibbonAwardAnim);
               this._awardItemRenderers.push(_loc1_);
            }
            else
            {
               _loc1_ = this._awardItemRenderers[_loc3_];
            }
            _loc1_.setRendererData(this._data.awards[_loc3_]);
            _loc1_.setRendererSize(this._data.rendererWidth,this._data.rendererHeight);
            _loc3_++;
         }
         this._lastAwardItem = this._awardItemRenderers[this._awardsCount - 1];
         if(this._lastAwardItem)
         {
            this._lastAwardItem.addEventListener(RibbonAwardAnimEvent.AWARD_FADE_IN_COMPLETE,this.onLastItemAwardFadeInCompleteHandler);
            this._lastAwardItem.addEventListener(RibbonAwardAnimEvent.AWARD_BLINK_COMPLETE,this.onLastItemAwardBlinkCompleteHandler);
            this._lastAwardItem.addEventListener(RibbonAwardAnimEvent.AWARD_FADE_OUT_COMPLETE,this.onLastItemAwardFadeOutCompleteHandler);
         }
      }
      
      private function drawAwardItemRenderers() : void
      {
         var _loc1_:IRibbonAwardAnim = null;
         var _loc2_:uint = this._data.gap + this._data.rendererWidth;
         var _loc3_:int = _loc2_ * this._awardsCount - this._data.gap >> 1;
         var _loc4_:int = -this._data.rendererHeight >> 1;
         var _loc5_:uint = 0;
         while(_loc5_ < this._awardsCount)
         {
            _loc1_ = this._awardItemRenderers[_loc5_];
            _loc1_.x = _loc2_ * _loc5_ - _loc3_;
            _loc1_.y = _loc4_ + this._data.rendererYOffset;
            addChild(DisplayObject(_loc1_));
            _loc5_++;
         }
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      private function onFadeInComplete() : void
      {
         this.ribbonAnim.stop();
         this.fadeInAwards();
      }
      
      private function onFadeOutComplete() : void
      {
         this.ribbonAnim.stop();
      }
      
      private function onLastItemAwardFadeInCompleteHandler(param1:RibbonAwardAnimEvent) : void
      {
         dispatchEvent(new RibbonAwardAnimEvent(RibbonAwardAnimEvent.RIBBON_FADE_IN_COMPLETE));
      }
      
      private function onLastItemAwardBlinkCompleteHandler(param1:RibbonAwardAnimEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function onLastItemAwardFadeOutCompleteHandler(param1:RibbonAwardAnimEvent) : void
      {
         dispatchEvent(new RibbonAwardAnimEvent(RibbonAwardAnimEvent.RIBBON_FADE_OUT_COMPLETE));
      }
   }
}
