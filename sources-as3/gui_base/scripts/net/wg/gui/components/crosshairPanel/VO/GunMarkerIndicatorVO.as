package net.wg.gui.components.crosshairPanel.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class GunMarkerIndicatorVO extends DAAPIDataClass
   {
       
      
      public var shellIntCD:int = -1;
      
      public var shellTypeName:String = "";
      
      public var shotResult:int = 0;
      
      public var state:int = 0;
      
      public function GunMarkerIndicatorVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
