package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class QuestDashlineItemVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var linkID:String = "";
      
      public var isNotAvailable:Boolean;
      
      public var value:String = "";
      
      public var linkage:String = "";
      
      public function QuestDashlineItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
