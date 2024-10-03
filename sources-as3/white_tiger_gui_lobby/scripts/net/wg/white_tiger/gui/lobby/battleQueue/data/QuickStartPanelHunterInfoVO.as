package net.wg.white_tiger.gui.lobby.battleQueue.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class QuickStartPanelHunterInfoVO extends DAAPIDataClass
   {
       
      
      public var typeIcon:String = "";
      
      public var icon:String = "";
      
      public var name:String = "";
      
      public var vehID:int = -1;
      
      public var isInBattle:Boolean = false;
      
      public function QuickStartPanelHunterInfoVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
