package net.wg.gui.battle.epicBattle.views.upgradePanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EpicConfiguratorModuleVO extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var level:int = -1;
      
      public var intCD:int = 0;
      
      public var selected:Boolean = false;
      
      public var available:Boolean = false;
      
      public var gap:int = 0;
      
      public function EpicConfiguratorModuleVO(param1:Object)
      {
         super(param1);
      }
      
      public function update(param1:EpicConfiguratorModuleVO) : void
      {
         this.selected = param1.selected;
         this.available = param1.available;
         this.level = param1.level;
      }
   }
}
