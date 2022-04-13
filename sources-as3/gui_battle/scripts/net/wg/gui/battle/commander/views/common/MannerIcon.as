package net.wg.gui.battle.commander.views.common
{
   import net.wg.data.constants.InvalidationType;
   
   public class MannerIcon extends BaseIcon
   {
       
      
      private var _mannerID:Number = 0;
      
      public function MannerIcon()
      {
         super();
      }
      
      public function set mannerID(param1:Number) : void
      {
         if(this._mannerID != param1)
         {
            this._mannerID = param1;
            invalidateData();
         }
      }
      
      public function get mannerID() : Number
      {
         return this._mannerID;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            visible = isShown && isAlive && this.mannerID > 0;
            if(visible)
            {
               gotoAndStop("manner_" + this._mannerID);
            }
         }
      }
   }
}
