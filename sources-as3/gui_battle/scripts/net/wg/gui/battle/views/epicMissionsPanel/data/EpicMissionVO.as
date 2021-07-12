package net.wg.gui.battle.views.epicMissionsPanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EpicMissionVO extends DAAPIDataClass
   {
       
      
      public var objectiveType:int = -1;
      
      public var objectiveID:int = -1;
      
      public var missionText:String = "";
      
      public var subText:String = "";
      
      public function EpicMissionVO(param1:Object)
      {
         super(param1);
      }
   }
}
