package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationItemVO extends DAAPIDataClass
   {
       
      
      public var header:String = "";
      
      public var kind:String = "";
      
      public var description:String = "";
      
      public var timeLeft:String = "";
      
      public var vehicleType:String = "";
      
      public function CustomizationItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
