package net.wg.gui.lobby.sessionStats.components
{
   import fl.transitions.easing.Strong;
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class SessionStatsAnimatedNumber extends Sprite implements IDisposable
   {
      
      private static const NUMBERS_COUNT:int = 10;
      
      private static const ANIMATION_SPEED:int = 1000;
      
      private static const ANIMATION_OFFSET:int = 90;
      
      private static const NEXT_LINE:String = "\n";
       
      
      public var counter:SessionStatsAnimatedNumberCounter = null;
      
      private var currentNumber:int = 0;
      
      private var currentTween:Tween = null;
      
      public function SessionStatsAnimatedNumber()
      {
         super();
      }
      
      public function goToNumber(param1:int) : void
      {
         this.currentNumber = param1;
         this.prepareNumbers(this.currentNumber);
         this.counter.y = -this.counter.height + ANIMATION_OFFSET;
      }
      
      public function animateTo(param1:int) : void
      {
         this.prepareNumbers(this.currentNumber,param1);
         this.gotoNextCycle();
      }
      
      private function prepareNumbers(param1:int, param2:int = -1) : void
      {
         var _loc3_:String = param1 + NEXT_LINE;
         var _loc4_:int = 0;
         if(param2 != Values.DEFAULT_INT)
         {
            if(param2 <= param1)
            {
               _loc4_ = param1;
               while(_loc4_ < NUMBERS_COUNT)
               {
                  _loc3_ += _loc4_ + NEXT_LINE;
                  _loc4_++;
               }
               _loc4_ = 0;
               while(_loc4_ < param2 + 1)
               {
                  _loc3_ += _loc4_ + NEXT_LINE;
                  _loc4_++;
               }
            }
            else
            {
               _loc4_ = param1 + 1;
               while(_loc4_ < param2 + 1)
               {
                  _loc3_ += _loc4_ + NEXT_LINE;
                  _loc4_++;
               }
            }
         }
         this.counter.text = _loc3_;
      }
      
      private function gotoNextCycle() : void
      {
         this.counter.y = 0;
         this.clearTween();
         this.currentTween = new Tween(ANIMATION_SPEED,this.counter,{"y":-this.counter.height + ANIMATION_OFFSET},{
            "ease":Strong.easeInOut,
            "onComplete":this.clearTween
         });
      }
      
      public function dispose() : void
      {
         this.clearTween();
         this.counter.dispose();
         this.counter = null;
      }
      
      private function clearTween() : void
      {
         if(this.currentTween)
         {
            this.currentTween.paused = true;
            this.currentTween.dispose();
            this.currentTween = null;
         }
      }
   }
}
