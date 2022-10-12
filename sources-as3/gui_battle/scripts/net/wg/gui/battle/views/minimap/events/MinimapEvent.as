package net.wg.gui.battle.views.minimap.events
{
   import flash.events.Event;
   
   public class MinimapEvent extends Event
   {
      
      public static const TRY_SIZE_CHANGED:String = "minimapTrySizeChanged";
      
      public static const SIZE_CHANGED:String = "minimapSizeChanged";
      
      public static const VISIBILITY_CHANGED:String = "minimapVisibilityChanged";
      
      public static const TRY_INIT_PREBATTLE_SIZE:String = "minimapTryInitPrebattleSize";
       
      
      public var sizeIndex:Number = 0;
      
      public function MinimapEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Number = 0)
      {
         this.sizeIndex = param4;
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new MinimapEvent(type,bubbles,cancelable,this.sizeIndex);
      }
      
      override public function toString() : String
      {
         return formatToString("MinimapEvent","type","bubbles","cancelable","sizeIndex");
      }
   }
}
