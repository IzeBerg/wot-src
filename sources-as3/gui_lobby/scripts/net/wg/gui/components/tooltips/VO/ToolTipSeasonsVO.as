package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ToolTipSeasonsVO extends DAAPIDataClass
   {
       
      
      public var seasonImage:String = "";
      
      public var header:String = "";
      
      public var body:String = "";
      
      public function ToolTipSeasonsVO(param1:Object)
      {
         super(param1);
      }
   }
}
