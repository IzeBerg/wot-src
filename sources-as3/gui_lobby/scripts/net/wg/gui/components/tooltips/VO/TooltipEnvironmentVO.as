package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TooltipEnvironmentVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var text:String = "";
      
      public var icon:String = "";
      
      public function TooltipEnvironmentVO(param1:Object)
      {
         super(param1);
      }
   }
}
