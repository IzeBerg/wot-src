package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class TrainingFormVO extends DAAPIDataClass
   {
      
      private static const LIST_DATA:String = "listData";
       
      
      public var roomsLabel:String = "";
      
      public var playersLabel:String = "";
      
      public var listData:DataProvider = null;
      
      public function TrainingFormVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == LIST_DATA && param2 != null)
         {
            this.listData = new DataProvider(param2 as Array);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.listData.cleanUp();
         this.listData = null;
         super.onDispose();
      }
   }
}
