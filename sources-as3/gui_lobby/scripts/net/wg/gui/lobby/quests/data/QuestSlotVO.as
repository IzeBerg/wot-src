package net.wg.gui.lobby.quests.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class QuestSlotVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var id:int = -1;
      
      public var inProgress:Boolean = false;
      
      public var completed:Boolean = false;
      
      public var ttHeader:String = "";
      
      public var ttBody:String = "";
      
      public var ttNote:String = "";
      
      public var ttAttention:String = "";
      
      public function QuestSlotVO(param1:Object)
      {
         super(param1);
      }
      
      public function get isEmpty() : Boolean
      {
         return !(this.inProgress || this.completed);
      }
   }
}
