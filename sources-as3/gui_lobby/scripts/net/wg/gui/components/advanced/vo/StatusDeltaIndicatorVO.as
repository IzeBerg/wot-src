package net.wg.gui.components.advanced.vo
{
   public class StatusDeltaIndicatorVO extends ProgressBarAnimVO
   {
       
      
      public var delta:Number = 0;
      
      public var markerValue:Number = -1;
      
      public var isOptional:Boolean = false;
      
      public function StatusDeltaIndicatorVO(param1:Object)
      {
         super(param1);
      }
   }
}
