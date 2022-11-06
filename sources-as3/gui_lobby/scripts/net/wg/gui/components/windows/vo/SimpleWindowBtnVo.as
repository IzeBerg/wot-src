package net.wg.gui.components.windows.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SimpleWindowBtnVo extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var btnLinkage:String = "";
      
      public var btnName:String = "";
      
      public var action:String = "";
      
      public var isFocused:Boolean = false;
      
      public var tooltip:String = "";
      
      public var enabled:Boolean = true;
      
      public var mouseEnabledOnDisabled:Boolean = false;
      
      public function SimpleWindowBtnVo(param1:Object)
      {
         super(param1);
      }
   }
}
