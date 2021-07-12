package net.wg.gui.components.advanced.interfaces
{
   import net.wg.gui.components.advanced.vo.TruncateHtmlTextVO;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IDashLineTextItem extends IUIComponentEx
   {
       
      
      function useTruncateValues(param1:TruncateHtmlTextVO) : void;
      
      function set label(param1:String) : void;
      
      function set tooltip(param1:String) : void;
      
      function set value(param1:String) : void;
   }
}
