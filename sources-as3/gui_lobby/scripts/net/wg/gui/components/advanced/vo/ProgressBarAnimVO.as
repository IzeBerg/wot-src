package net.wg.gui.components.advanced.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ProgressBarAnimVO extends DAAPIDataClass
   {
       
      
      public var value:Number = -1;
      
      public var maxValue:Number = -1;
      
      public var minValue:Number = 0;
      
      public var isGreen:Boolean = false;
      
      public var useAnim:Boolean = true;
      
      public function ProgressBarAnimVO(param1:Object)
      {
         super(param1);
      }
   }
}
