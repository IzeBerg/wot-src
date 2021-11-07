package net.wg.gui.battle.eventBattle.views.eventPointCounter
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.getTimer;
   import net.wg.gui.eventcomponents.NumberProgress;
   import net.wg.infrastructure.base.meta.IPveEventPointCounterMeta;
   import net.wg.infrastructure.base.meta.impl.PveEventPointCounterMeta;
   
   public class EventPointCounter extends PveEventPointCounterMeta implements IPveEventPointCounterMeta
   {
      
      private static const SOULS_VALUE1:int = 10;
      
      private static const SOULS_VALUE2:int = 100;
      
      private static const SIZE_1_TO_2:String = "size1to2";
      
      private static const SIZE_2_TO_3:String = "size2to3";
      
      private static const SIZE_3_TO_2:String = "size3to2";
      
      private static const SIZE_2_TO_1:String = "size2to1";
      
      private static const SIZE1:int = 1;
      
      private static const SIZE2:int = 2;
      
      private static const SIZE3:int = 3;
      
      private static const APPEAR:String = "appear";
      
      private static const ACTION_IN:String = "actionIn";
      
      private static const ACTION_OUT:String = "actionOut";
      
      private static const DISAPPEAR:String = "disappear";
      
      private static const TIME_ANIM_COUNT:int = 10;
      
      private static const TIME_ANIM_COUNT_DRAW:int = 5;
      
      private static const TIME_ANIM_DELTA:int = 100;
      
      private static const STEP_MIN:int = 1;
      
      private static const REASON_DRAW_BY_COLLECTOR:int = 2;
      
      private static const REASON_DRAW_BY_BOSS:int = 3;
       
      
      public var num:NumberProgress = null;
      
      public var fx:MovieClip = null;
      
      public var mc:EventPointCounterAnimation = null;
      
      public var appearFx:MovieClip = null;
      
      public var disappearFx:MovieClip = null;
      
      private var _countPrev:int = 0;
      
      private var _countNext:int = 0;
      
      private var _countStep:int = 0;
      
      private var _countSize:int = 1;
      
      private var _countChanged:Boolean = false;
      
      private var _timePrev:int = 0;
      
      private var _animationEnabled:Boolean = true;
      
      public function EventPointCounter()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(Event.ENTER_FRAME,this.onAnimEnterFrameHandler);
      }
      
      override protected function onDispose() : void
      {
         this.num.dispose();
         this.num = null;
         this.fx = null;
         this.mc.dispose();
         this.mc = null;
         this.appearFx = null;
         this.disappearFx = null;
         removeEventListener(Event.ENTER_FRAME,this.onAnimEnterFrameHandler);
         super.onDispose();
      }
      
      public function as_enableAnimation(param1:Boolean) : void
      {
         if(this._animationEnabled != param1)
         {
            this._animationEnabled = param1;
         }
      }
      
      public function as_updateCount(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         if(this._countNext != param1)
         {
            this._countNext = param1;
            this._countChanged = true;
            _loc3_ = param2 == REASON_DRAW_BY_BOSS || param2 == REASON_DRAW_BY_COLLECTOR ? int(TIME_ANIM_COUNT_DRAW) : int(TIME_ANIM_COUNT);
            this._countStep = Math.abs((this._countNext - this._countPrev) / _loc3_);
            if(this._countStep < STEP_MIN)
            {
               this._countStep = STEP_MIN;
            }
            if(this._countPrev == 0 && this._countNext > 0)
            {
               gotoAndPlay(APPEAR);
               if(!this._animationEnabled)
               {
                  this.mc.stopAnimation();
               }
               if(this._animationEnabled)
               {
                  this.appearFx.gotoAndPlay(APPEAR);
               }
            }
            else if(this._countPrev != this._countNext)
            {
               gotoAndPlay(ACTION_IN);
               if(!this._animationEnabled)
               {
                  this.mc.stopAnimation();
               }
            }
         }
      }
      
      private function playAnim() : void
      {
         if(this._countSize == SIZE1 && this._countPrev >= SOULS_VALUE1)
         {
            if(this._countSize != SIZE2)
            {
               this._countSize = SIZE2;
               this.fx.gotoAndPlay(SIZE_1_TO_2);
               this.mc.gotoAndPlay(SIZE_1_TO_2);
            }
         }
         else if(this._countSize == SIZE2 && this._countPrev >= SOULS_VALUE2)
         {
            if(this._countSize != SIZE3)
            {
               this._countSize = SIZE3;
               this.fx.gotoAndPlay(SIZE_2_TO_3);
               this.mc.gotoAndPlay(SIZE_2_TO_3);
            }
         }
         else if(this._countSize == SIZE3 && this._countPrev < SOULS_VALUE2)
         {
            if(this._countSize != SIZE2)
            {
               this._countSize = SIZE2;
               this.fx.gotoAndPlay(SIZE_3_TO_2);
               this.mc.gotoAndPlay(SIZE_3_TO_2);
            }
         }
         else if(this._countSize == SIZE2 && this._countPrev < SOULS_VALUE1)
         {
            if(this._countSize != SIZE1)
            {
               this._countSize = SIZE1;
               this.fx.gotoAndPlay(SIZE_2_TO_1);
               this.mc.gotoAndPlay(SIZE_2_TO_1);
            }
         }
      }
      
      private function onAnimEnterFrameHandler(param1:Event) : void
      {
         var _loc2_:int = getTimer();
         if(_loc2_ < this._timePrev + TIME_ANIM_DELTA)
         {
            return;
         }
         if(this._countNext < this._countPrev)
         {
            this._countPrev -= this._countStep;
            if(this._countNext > this._countPrev)
            {
               this._countPrev = this._countNext;
            }
         }
         else
         {
            if(this._countNext <= this._countPrev)
            {
               if(this._countChanged)
               {
                  this._countChanged = false;
                  if(this._countNext == 0)
                  {
                     gotoAndPlay(DISAPPEAR);
                     if(this._animationEnabled)
                     {
                        this.disappearFx.gotoAndPlay(APPEAR);
                     }
                  }
                  else
                  {
                     gotoAndPlay(ACTION_OUT);
                  }
               }
               return;
            }
            this._countPrev += this._countStep;
            if(this._countNext < this._countPrev)
            {
               this._countPrev = this._countNext;
            }
         }
         if(this._animationEnabled)
         {
            this.playAnim();
         }
         else
         {
            this.mc.stopAnimation();
         }
         this.num.setText(this._countPrev.toString());
         this._timePrev = _loc2_;
      }
   }
}
