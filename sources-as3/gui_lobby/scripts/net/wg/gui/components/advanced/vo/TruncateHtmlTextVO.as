package net.wg.gui.components.advanced.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TruncateHtmlTextVO extends DAAPIDataClass
   {
       
      
      public var isUseTruncate:Boolean = false;
      
      public var textStyle:String = "";
      
      public var maxWidthTF:int = -1;
      
      public function TruncateHtmlTextVO(param1:Object)
      {
         super(param1);
      }
   }
}
