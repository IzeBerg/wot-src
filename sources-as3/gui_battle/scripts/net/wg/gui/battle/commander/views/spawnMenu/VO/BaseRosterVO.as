package net.wg.gui.battle.commander.views.spawnMenu.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BaseRosterVO extends DAAPIDataClass
   {
       
      
      public var vehicleIcon:String = "";
      
      public var vehicleName:String = "";
      
      public var vehicleType:String = "";
      
      public var vehicleLevel:int = 0;
      
      public var isSettled:Boolean = false;
      
      public var isSelected:Boolean = false;
      
      public var isDragged:Boolean = false;
      
      public function BaseRosterVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
