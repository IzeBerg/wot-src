package net.wg.gui.battle.views.questProgress.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class QuestProgressPerformVO extends DAAPIDataClass
   {
       
      
      public var hasQuestToPerform:Boolean = true;
      
      public var noQuestTitle:String = "";
      
      public var noQuestDescr:String = "";
      
      public function QuestProgressPerformVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
