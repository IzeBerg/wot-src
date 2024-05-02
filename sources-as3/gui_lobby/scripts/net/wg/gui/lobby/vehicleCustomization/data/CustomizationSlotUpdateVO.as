package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationSlotUpdateVO extends DAAPIDataClass
   {
      
      private static const SLOT_ID:String = "slotId";
       
      
      public var slotId:CustomizationSlotIdVO = null;
      
      public var itemIntCD:int = -1;
      
      public var uid:uint = 1.0;
      
      public function CustomizationSlotUpdateVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == SLOT_ID)
         {
            this.slotId = new CustomizationSlotIdVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.slotId != null)
         {
            this.slotId.dispose();
            this.slotId = null;
         }
         super.onDispose();
      }
   }
}
