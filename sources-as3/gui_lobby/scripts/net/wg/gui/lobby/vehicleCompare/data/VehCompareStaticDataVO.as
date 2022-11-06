package net.wg.gui.lobby.vehicleCompare.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehCompareStaticDataVO extends DAAPIDataClass
   {
      
      private static const HEADER_FIELD_NAME:String = "header";
       
      
      public var header:VehCompareHeaderVO = null;
      
      public function VehCompareStaticDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == HEADER_FIELD_NAME)
         {
            this.header = new VehCompareHeaderVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.header.dispose();
         this.header = null;
         super.onDispose();
      }
   }
}
