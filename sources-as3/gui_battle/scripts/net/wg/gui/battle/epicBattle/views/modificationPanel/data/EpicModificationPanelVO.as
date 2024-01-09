package net.wg.gui.battle.epicBattle.views.modificationPanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EpicModificationPanelVO extends DAAPIDataClass
   {
       
      
      public var modificationIconPath:String = "";
      
      public var modificationTitle:String = "";
      
      public var modificationDescription:String = "";
      
      public function EpicModificationPanelVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
