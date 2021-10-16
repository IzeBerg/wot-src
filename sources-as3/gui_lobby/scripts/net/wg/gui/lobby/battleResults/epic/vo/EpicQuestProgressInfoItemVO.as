package net.wg.gui.lobby.battleResults.epic.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.utils.IDataUtils;
   
   public class EpicQuestProgressInfoItemVO extends DAAPIDataClass
   {
       
      
      public var id:String = "";
      
      public var eventType:Number;
      
      public var name:String = "";
      
      public var rewards:Array = null;
      
      public var status:String = "";
      
      public var statusTooltip:String = "";
      
      public var progressList:Array = null;
      
      public function EpicQuestProgressInfoItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:IDataUtils = App.utils.data;
         if(this.progressList != null)
         {
            _loc1_.cleanupDynamicObject(this.progressList);
            this.progressList = null;
         }
         if(this.rewards)
         {
            for each(_loc2_ in this.rewards)
            {
               _loc2_.dispose();
            }
            _loc1_.cleanupDynamicObject(this.rewards);
            this.rewards = null;
         }
         super.onDispose();
      }
   }
}
