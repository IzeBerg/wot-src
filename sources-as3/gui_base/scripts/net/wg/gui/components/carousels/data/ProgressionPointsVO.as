package net.wg.gui.components.carousels.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ProgressionPointsVO extends DAAPIDataClass
   {
       
      
      public var currentPoints:String = "";
      
      public var limitPoints:String = "";
      
      public var limitReached:Boolean = false;
      
      public var isSpecialVehicle:Boolean = false;
      
      public function ProgressionPointsVO(param1:Object)
      {
         super(param1);
      }
   }
}
