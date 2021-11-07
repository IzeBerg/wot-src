package net.wg.gui.components.tooltips.VO
{
   public class ToolTipStatusColorsVO
   {
       
      
      public var textColor:uint = 0;
      
      public var filters:Array;
      
      public var headerFontSize:Number = 14;
      
      public var headerFontFace:String = "$TitleFont";
      
      public var infoFontSize:Number = 12;
      
      public var infoFontFace:String = "$FieldFont";
      
      public function ToolTipStatusColorsVO()
      {
         this.filters = [];
         super();
      }
   }
}
