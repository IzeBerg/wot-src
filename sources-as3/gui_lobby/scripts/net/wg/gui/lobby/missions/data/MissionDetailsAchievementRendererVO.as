package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MissionDetailsAchievementRendererVO extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var label:String = "";
      
      public var tooltip:String = "";
      
      public var block:String = "";
      
      public var type:String = "";
      
      public function MissionDetailsAchievementRendererVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
