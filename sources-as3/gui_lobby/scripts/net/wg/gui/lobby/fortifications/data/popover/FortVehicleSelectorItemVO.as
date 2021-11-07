package net.wg.gui.lobby.fortifications.data.popover
{
   import net.wg.gui.lobby.eventBoards.data.VehicleRendererItemVO;
   
   public class FortVehicleSelectorItemVO extends VehicleRendererItemVO
   {
       
      
      public var isMultiSelect:Boolean = false;
      
      public var state:String = "";
      
      public var tooltip:String = "";
      
      public var isReadyToFight:Boolean = false;
      
      public var enabled:Boolean = true;
      
      public function FortVehicleSelectorItemVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
