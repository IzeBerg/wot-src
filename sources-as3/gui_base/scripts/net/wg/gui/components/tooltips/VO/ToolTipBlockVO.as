package net.wg.gui.components.tooltips.VO
{
   import flash.display.MovieClip;
   import flash.text.StyleSheet;
   
   public class ToolTipBlockVO
   {
       
      
      public var contener:MovieClip = null;
      
      public var startYPos:Number = 0;
      
      public var childrenNamePrefix:String = "";
      
      public var header:String = "";
      
      public var leftText:String = "";
      
      public var leftTextLeading:Number = 2;
      
      public var leftTextFont:String = "$TextFont";
      
      public var leftTextSize:Number = 11;
      
      public var leftTextLineHight:Number = 0;
      
      public var leftTextColor:Number = 16777215;
      
      public var rightTextList:Vector.<ToolTipBlockRightListItemVO> = null;
      
      public var rightTextColor:Number = 16777215;
      
      public var rightTextCSS:StyleSheet = null;
      
      public var rightTextStartYPos:Number = 0;
      
      public function ToolTipBlockVO()
      {
         super();
      }
   }
}
