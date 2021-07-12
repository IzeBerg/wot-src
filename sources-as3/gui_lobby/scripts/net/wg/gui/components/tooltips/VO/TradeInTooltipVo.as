package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TradeInTooltipVo extends DAAPIDataClass
   {
       
      
      public var header:String = "";
      
      public var body:String = "";
      
      public var result:String = "";
      
      public function TradeInTooltipVo(param1:Object = null)
      {
         super(param1);
      }
   }
}
