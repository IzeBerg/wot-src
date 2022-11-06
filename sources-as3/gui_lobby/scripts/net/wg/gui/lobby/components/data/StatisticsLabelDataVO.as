package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class StatisticsLabelDataVO extends DAAPIDataClass
   {
      
      private static const DATA:String = "data";
       
      
      public var label:String = "";
      
      public var data:Object = null;
      
      public function StatisticsLabelDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == DATA)
         {
            this.parseData(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }
      
      override protected function onDispose() : void
      {
         this.data = null;
         super.onDispose();
      }
      
      protected function parseData(param1:Object) : void
      {
         this.data = param1;
      }
   }
}
