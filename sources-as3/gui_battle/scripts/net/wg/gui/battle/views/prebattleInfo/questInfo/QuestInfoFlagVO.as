package net.wg.gui.battle.views.prebattleInfo.questInfo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class QuestInfoFlagVO extends DAAPIDataClass
   {
       
      
      public var questName:String = "";
      
      public var questIndexStr:String = "";
      
      public var questIcon:String = "";
      
      public function QuestInfoFlagVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
