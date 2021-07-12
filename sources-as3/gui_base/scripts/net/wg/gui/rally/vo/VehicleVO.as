package net.wg.gui.rally.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleVO extends DAAPIDataClass
   {
       
      
      public var intCD:uint;
      
      public var nationID:uint;
      
      public var name:String = "";
      
      public var userName:String = "";
      
      public var shortUserName:String = "";
      
      public var level:uint;
      
      public var smallIconPath:String = "";
      
      public var type:String = "";
      
      public var typeIndex:uint = 0;
      
      public var isReadyToFight:Boolean = false;
      
      public var enabled:Boolean = true;
      
      public var tooltip:String = "";
      
      public var state:String = "";
      
      public var isEventVehicle:Boolean = false;
      
      public function VehicleVO(param1:Object)
      {
         super(param1);
      }
   }
}
