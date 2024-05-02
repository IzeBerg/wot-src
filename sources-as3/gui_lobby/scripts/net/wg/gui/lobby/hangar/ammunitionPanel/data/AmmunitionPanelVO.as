package net.wg.gui.lobby.hangar.ammunitionPanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AmmunitionPanelVO extends DAAPIDataClass
   {
       
      
      public var maintenanceEnabled:Boolean = false;
      
      public var maintenanceVisible:Boolean = true;
      
      public var maintenanceTooltip:String = "";
      
      public var customizationEnabled:Boolean = false;
      
      public var customizationVisible:Boolean = true;
      
      public var customizationTooltip:String = "";
      
      public var changeNationVisible:Boolean = false;
      
      public var changeNationEnable:Boolean = false;
      
      public var changeNationTooltip:String = "";
      
      public var changeNationIsNew:Boolean = false;
      
      public function AmmunitionPanelVO(param1:Object)
      {
         super(param1);
      }
   }
}
