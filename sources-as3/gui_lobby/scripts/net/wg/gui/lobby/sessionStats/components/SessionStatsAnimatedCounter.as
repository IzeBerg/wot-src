package net.wg.gui.lobby.sessionStats.components
{
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SessionStatsAnimatedCounter extends UIComponentEx
   {
      
      public static const NUMBERS_COUNT:int = 10;
       
      
      public var number_1:SessionStatsAnimatedNumber = null;
      
      public var number_2:SessionStatsAnimatedNumber = null;
      
      public var number_3:SessionStatsAnimatedNumber = null;
      
      public var number_4:SessionStatsAnimatedNumber = null;
      
      private var numbers:Vector.<SessionStatsAnimatedNumber> = null;
      
      private var currentNumberV:Vector.<int>;
      
      private var targetNumberV:Vector.<int>;
      
      public function SessionStatsAnimatedCounter()
      {
         super();
      }
      
      private static function numberToVector(param1:int) : Vector.<int>
      {
         var _loc2_:Vector.<int> = new Vector.<int>();
         do
         {
            _loc2_.push(param1 % NUMBERS_COUNT);
            param1 /= NUMBERS_COUNT;
         }
         while(param1 > 0);
         
         return _loc2_.reverse();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.numbers = new Vector.<SessionStatsAnimatedNumber>();
         this.numbers.push(this.number_1);
         this.numbers.push(this.number_2);
         this.numbers.push(this.number_3);
         this.numbers.push(this.number_4);
      }
      
      public function goToNumber(param1:int) : void
      {
         this.currentNumberV = numberToVector(param1);
         this.applyCurrentNumber();
      }
      
      public function animateTo(param1:int) : void
      {
         this.targetNumberV = numberToVector(param1);
         this.animateToTarget();
      }
      
      private function animateToTarget() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = this.numbers.length;
         var _loc3_:int = this.targetNumberV.length;
         var _loc4_:SessionStatsAnimatedNumber = null;
         var _loc5_:Boolean = _loc3_ != this.currentNumberV.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.numbers[_loc1_];
            if(_loc2_ - _loc3_ <= _loc1_)
            {
               if(!_loc5_)
               {
                  _loc5_ = this.targetNumberV[_loc1_ - (_loc2_ - _loc3_)] != this.currentNumberV[_loc1_ - (_loc2_ - _loc3_)];
               }
               if(_loc5_)
               {
                  _loc4_.visible = true;
                  _loc4_.animateTo(this.targetNumberV[_loc1_ - (_loc2_ - _loc3_)]);
               }
            }
            else
            {
               _loc4_.visible = false;
               _loc4_.goToNumber(0);
            }
            _loc1_++;
         }
         this.currentNumberV = this.targetNumberV;
         gotoAndStop(this.currentNumberV.length);
      }
      
      private function applyCurrentNumber() : void
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         _loc1_ = this.numbers.length;
         var _loc2_:int = this.currentNumberV.length;
         var _loc3_:SessionStatsAnimatedNumber = null;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = this.numbers[_loc4_];
            if(_loc1_ - _loc2_ <= _loc4_)
            {
               _loc3_.visible = true;
               _loc3_.goToNumber(this.currentNumberV[_loc4_ - (_loc1_ - _loc2_)]);
            }
            else
            {
               _loc3_.visible = false;
               _loc3_.goToNumber(0);
            }
            _loc4_++;
         }
         gotoAndStop(_loc2_);
      }
      
      override protected function onDispose() : void
      {
         this.number_1.dispose();
         this.number_1 = null;
         this.number_2.dispose();
         this.number_2 = null;
         this.number_3.dispose();
         this.number_3 = null;
         this.number_4.dispose();
         this.number_4 = null;
         super.onDispose();
      }
   }
}
