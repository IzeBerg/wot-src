package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CustomizationAnchorsStateVO extends DAAPIDataClass
   {
      
      private static const ANCHORS_DATA_LABEL:String = "anchorsData";
       
      
      public var anchorsData:Vector.<CustomziationAnchorStateVO> = null;
      
      public function CustomizationAnchorsStateVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == ANCHORS_DATA_LABEL)
         {
            this.anchorsData = new Vector.<CustomziationAnchorStateVO>();
            for each(_loc3_ in param2)
            {
               this.anchorsData.push(new CustomziationAnchorStateVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.anchorsData != null)
         {
            for each(_loc1_ in this.anchorsData)
            {
               _loc1_.dispose();
            }
            this.anchorsData.splice(0,this.anchorsData.length);
            this.anchorsData = null;
         }
         super.onDispose();
      }
   }
}
