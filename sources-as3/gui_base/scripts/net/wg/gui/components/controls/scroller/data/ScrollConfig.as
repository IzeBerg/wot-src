package net.wg.gui.components.controls.scroller.data
{
   public class ScrollConfig
   {
       
      
      public var elasticity:Number = 0.1;
      
      public var elasticMaxDelta:Number = 100;
      
      public var elasticSnapDuration:Number = 0.5;
      
      public var throwElasticity:Number = 0.05;
      
      public var mouseWheelScrollDuration:Number = 0.5;
      
      public var mouseWheelScrollPercent:Number = 1;
      
      public var normalizeWheelScrollDelta:Boolean = true;
      
      public var minDragDistance:Number = 0.04;
      
      public var minVelocityPerMs:Number = 0.02;
      
      public var minThrowVelocityPerMs:Number = 0.5;
      
      public var velocityWeight:Number = 2.33;
      
      public var throwAccelerationRate:Number = 1;
      
      public function ScrollConfig()
      {
         super();
      }
   }
}
