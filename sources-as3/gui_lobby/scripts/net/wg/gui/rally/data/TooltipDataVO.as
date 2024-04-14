package net.wg.gui.rally.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TooltipDataVO extends DAAPIDataClass
   {
       
      
      public var id:String = "";
      
      public var header:Object;
      
      public var body:Object;
      
      public function TooltipDataVO(param1:Object)
      {
         super(param1);
      }
   }
}
