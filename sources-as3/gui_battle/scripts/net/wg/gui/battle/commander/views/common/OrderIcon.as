package net.wg.gui.battle.commander.views.common
{
   import net.wg.data.constants.InvalidationType;
   
   public class OrderIcon extends BaseIcon
   {
       
      
      private var _orderID:Number = 0;
      
      private var _isVisible:Boolean = false;
      
      public function OrderIcon()
      {
         super();
      }
      
      public function set orderID(param1:Number) : void
      {
         if(this._orderID != param1)
         {
            this._orderID = param1;
            invalidateData();
         }
      }
      
      public function get orderID() : Number
      {
         return this._orderID;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            visible = isShown && isAlive && this.orderID > 0;
            if(visible)
            {
               gotoAndStop(this.orderID);
            }
         }
      }
   }
}
