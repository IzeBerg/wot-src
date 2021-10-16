package net.wg.gui.battle.views.destroyTimers.components
{
   public class SecondaryTimerSetting
   {
      
      public static const DEFAULT_PRIORITY:uint = 10000;
       
      
      public var text:String = "";
      
      public var iconName:String = "";
      
      public var state:String = "";
      
      public var noiseVisible:Boolean = false;
      
      public var pulseVisible:Boolean = false;
      
      public var linkage:String = "";
      
      public var priority:uint = 10000;
      
      public var bgVisible:Boolean = true;
      
      public var countdownVisible:Boolean = true;
      
      public var isCanBeMainType:Boolean = false;
      
      public function SecondaryTimerSetting(param1:String, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:String)
      {
         super();
         this.text = param1;
         this.iconName = param2;
         this.state = param3;
         this.noiseVisible = param4;
         this.pulseVisible = param5;
         this.linkage = param6;
      }
   }
}
