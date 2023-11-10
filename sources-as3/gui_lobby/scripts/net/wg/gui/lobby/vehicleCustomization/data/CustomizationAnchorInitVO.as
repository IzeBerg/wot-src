package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationAnchorInitVO extends DAAPIDataClass
   {
      
      private static const ANCHOR_VOS:String = "anchorUpdateVOs";
       
      
      public var anchorUpdateVOs:Vector.<CustomizationSlotUpdateVO> = null;
      
      public var typeRegions:int = -1;
      
      public function CustomizationAnchorInitVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == ANCHOR_VOS)
         {
            this.anchorUpdateVOs = new Vector.<CustomizationSlotUpdateVO>();
            for each(_loc3_ in param2)
            {
               this.anchorUpdateVOs.push(new CustomizationSlotUpdateVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:CustomizationSlotUpdateVO = null;
         if(this.anchorUpdateVOs != null)
         {
            for each(_loc1_ in this.anchorUpdateVOs)
            {
               _loc1_.dispose();
            }
            this.anchorUpdateVOs.splice(0,this.anchorUpdateVOs.length);
            this.anchorUpdateVOs = null;
         }
         super.onDispose();
      }
   }
}
