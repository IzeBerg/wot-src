package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TextBlockVO extends DAAPIDataClass
   {
       
      
      public var text:String = "";
      
      public var useHtml:Boolean = true;
      
      public function TextBlockVO(param1:Object)
      {
         super(param1);
      }
   }
}
