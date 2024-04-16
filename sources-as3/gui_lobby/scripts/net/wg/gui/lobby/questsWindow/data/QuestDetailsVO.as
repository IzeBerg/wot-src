package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class QuestDetailsVO extends DAAPIDataClass
   {
       
      
      public var linkage:String = "";
      
      public var componentAlias:String = "";
      
      public var questID:String = "";
      
      public function QuestDetailsVO(param1:Object)
      {
         super(param1);
      }
   }
}
