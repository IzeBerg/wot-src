package net.wg.gui.battle.views.destroyTimers.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class NotificationTimerSettingVO extends DAAPIDataClass
   {
      
      private static const DEFAULT_PRIORITY:uint = 10000;
       
      
      public var typeId:String = "";
      
      public var iconName:String = "";
      
      public var iconSmallName:String = "";
      
      public var linkage:String = "";
      
      public var color:String = "";
      
      public var text:String = "";
      
      public var noiseVisible:Boolean = false;
      
      public var pulseVisible:Boolean = false;
      
      public var priority:uint = 10000;
      
      public var countdownVisible:Boolean = true;
      
      public var isCanBeMainType:Boolean = false;
      
      public var isReversedTimerDirection:Boolean = false;
      
      public var iconOffsetY:int = -1;
      
      public var canBlink:Boolean = false;
      
      public var descriptionFontSize:int = 14;
      
      public var descriptionOffsetY:int = 0;
      
      public var description:String = "";
      
      public var tipKeyCode:int = -1;
      
      public function NotificationTimerSettingVO(param1:Object)
      {
         super(param1);
      }
   }
}
