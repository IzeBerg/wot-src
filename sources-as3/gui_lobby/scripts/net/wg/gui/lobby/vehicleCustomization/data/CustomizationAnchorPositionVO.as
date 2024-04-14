package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationAnchorPositionVO extends DAAPIDataClass
   {
      
      private static const ANCHOR_ID:String = "slotId";
       
      
      public var anchorId:CustomizationSlotIdVO = null;
      
      public var zIndex:int = -1;
      
      public function CustomizationAnchorPositionVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ANCHOR_ID)
         {
            this.anchorId = new CustomizationSlotIdVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.anchorId != null)
         {
            this.anchorId.dispose();
            this.anchorId = null;
         }
         super.onDispose();
      }
   }
}
