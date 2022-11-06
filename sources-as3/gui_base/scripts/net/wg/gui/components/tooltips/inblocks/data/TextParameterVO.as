package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TextParameterVO extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var value:String = "";
      
      public var useHtmlName:Boolean = true;
      
      public var useHtmlValue:Boolean = true;
      
      public var highlight:Boolean = false;
      
      public var valueWidth:int = -1;
      
      public var gap:int = -1;
      
      public function TextParameterVO(param1:Object)
      {
         super(param1);
      }
   }
}
