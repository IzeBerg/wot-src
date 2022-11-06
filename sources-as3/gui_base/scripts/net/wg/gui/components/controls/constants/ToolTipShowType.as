package net.wg.gui.components.controls.constants
{
   public class ToolTipShowType
   {
      
      public static const COMPLEX:ToolTipShowType = new ToolTipShowType(0);
      
      public static const SPECIAL:ToolTipShowType = new ToolTipShowType(1);
       
      
      private var _value:int;
      
      public function ToolTipShowType(param1:int)
      {
         super();
         this._value = param1;
      }
      
      public function get value() : int
      {
         return this._value;
      }
   }
}
