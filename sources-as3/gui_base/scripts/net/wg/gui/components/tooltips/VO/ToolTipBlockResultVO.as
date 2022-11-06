package net.wg.gui.components.tooltips.VO
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconText;
   
   public class ToolTipBlockResultVO
   {
       
      
      public var startYPos:Number = NaN;
      
      public var leftTextField:TextField = null;
      
      public var elRightList:Vector.<IconText> = null;
      
      public var centerList:Array = null;
      
      public var headerTextField:TextField = null;
      
      public var hasIcons:Boolean = false;
      
      public var leftPartMaxW:Number = NaN;
      
      public var blockWidth:Number = NaN;
      
      public function ToolTipBlockResultVO(param1:Number, param2:TextField, param3:Vector.<IconText>, param4:Array, param5:TextField, param6:Boolean, param7:Number, param8:Number)
      {
         super();
         this.startYPos = param1;
         this.leftTextField = param2;
         this.elRightList = param3;
         this.centerList = param4;
         this.headerTextField = param5;
         this.hasIcons = param6;
         this.leftPartMaxW = param7;
         this.blockWidth = param8;
      }
   }
}
