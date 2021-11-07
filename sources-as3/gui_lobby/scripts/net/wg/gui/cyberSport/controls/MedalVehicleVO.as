package net.wg.gui.cyberSport.controls
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MedalVehicleVO extends DAAPIDataClass
   {
       
      
      public var inventoryID:Number = NaN;
      
      public var nationID:int = -1;
      
      public var vIcon:String = "";
      
      public var vName:String = "";
      
      public var vLevel:int = -1;
      
      public var vType:String = "";
      
      public function MedalVehicleVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
