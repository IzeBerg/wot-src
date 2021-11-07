package net.wg.gui.components.crosshairPanel
{
   public class CrosshairWithCassette extends CrosshairBase
   {
       
      
      private var _cassettePositions:Array = null;
      
      public function CrosshairWithCassette()
      {
         super();
         this._cassettePositions = this.getCassettePositions();
      }
      
      override public function dispose() : void
      {
         if(this._cassettePositions)
         {
            this._cassettePositions.splice(0,this._cassettePositions.length);
            this._cassettePositions = null;
         }
         super.dispose();
      }
      
      override protected function updateNetType() : void
      {
         super.updateNetType();
         cassetteMC.y = this._cassettePositions[netType];
      }
      
      protected function getCassettePositions() : Array
      {
         return null;
      }
   }
}
