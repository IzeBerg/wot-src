package net.wg.gui.lobby.profile.components.chart
{
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class BarItem extends UIComponentEx
   {
      
      public static const PERCENT_INV:String = "percInv";
       
      
      private var _percent:uint = 0;
      
      public function BarItem()
      {
         super();
         this.gotoAndStop(1);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(PERCENT_INV))
         {
            this.gotoAndStop(this._percent);
         }
      }
      
      public function get percent() : uint
      {
         return this._percent;
      }
      
      public function set percent(param1:uint) : void
      {
         this._percent = param1;
         invalidate(PERCENT_INV);
      }
   }
}
