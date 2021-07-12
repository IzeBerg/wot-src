package net.wg.gui.components.battleDamagePanel.models
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MessageRenderModel extends DAAPIDataClass
   {
       
      
      public var value:String = "";
      
      public var actionTypeImg:String = "";
      
      public var vehicleTypeImg:String = "";
      
      public var vehicleName:String = "";
      
      public var shellTypeStr:String = "";
      
      public var shellTypeBG:String = "";
      
      public function MessageRenderModel(param1:Object = null)
      {
         super(param1);
      }
   }
}
