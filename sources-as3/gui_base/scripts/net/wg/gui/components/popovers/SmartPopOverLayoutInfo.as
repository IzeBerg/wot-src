package net.wg.gui.components.popovers
{
   public class SmartPopOverLayoutInfo
   {
       
      
      public var arrowDirection:int;
      
      public var arrowPosition:int;
      
      public var popupPaddingTop:int;
      
      public var popupPaddingLeft:int;
      
      public function SmartPopOverLayoutInfo(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         this.arrowDirection = param1;
         this.arrowPosition = param2;
         this.popupPaddingLeft = param3;
         this.popupPaddingTop = param4;
      }
   }
}
