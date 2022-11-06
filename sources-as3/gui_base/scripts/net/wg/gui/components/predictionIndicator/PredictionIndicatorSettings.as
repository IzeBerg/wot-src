package net.wg.gui.components.predictionIndicator
{
   public class PredictionIndicatorSettings
   {
       
      
      public var index:int = 0;
      
      public var x:int = 0;
      
      public var y:int = 0;
      
      public var yaw:Number = 0;
      
      public function PredictionIndicatorSettings(param1:int, param2:int, param3:int, param4:Number)
      {
         super();
         this.x = param2;
         this.index = param1;
         this.y = param3;
         this.yaw = param4;
      }
   }
}
