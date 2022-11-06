package net.wg.gui.lobby.profile.components
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
   
   public class TechMasteryIcon extends Image
   {
       
      
      private var _data:TechniqueListVehicleVO = null;
      
      public function TechMasteryIcon()
      {
         super();
         this.addEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler,false,0,true);
      }
      
      override protected function onDispose() : void
      {
         this.removeEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
         this._data = null;
         super.onDispose();
      }
      
      public function set data(param1:TechniqueListVehicleVO) : void
      {
         this._data = param1;
      }
      
      private function rollOverHandler(param1:MouseEvent) : void
      {
         if(this._data)
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.MARK_OF_MASTERY,null,this._data.markOfMasteryBlock,"markOfMastery",this._data.markOfMastery);
         }
      }
      
      private function rollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
