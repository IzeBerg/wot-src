package net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationPropertiesSheetVO extends DAAPIDataClass
   {
      
      private static const RENDERERS:String = "renderersData";
       
      
      public var isBigRadius:Boolean = false;
      
      public var renderersData:Vector.<Object> = null;
      
      public var showSwitchers:Boolean = false;
      
      public var isNarrowSlot:Boolean = false;
      
      public function CustomizationPropertiesSheetVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == RENDERERS && param2 != null)
         {
            this.renderersData = new Vector.<Object>();
            for each(_loc3_ in param2)
            {
               this.renderersData.push(_loc3_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.renderersData != null)
         {
            this.renderersData.splice(0,this.renderersData.length);
            this.renderersData = null;
         }
         super.onDispose();
      }
   }
}
