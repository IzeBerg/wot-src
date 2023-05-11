package net.wg.gui.lobby.profile.pages.technique
{
   import flash.events.Event;
   import net.wg.gui.lobby.components.DetailedStatisticsGroupEx;
   import net.wg.gui.lobby.components.DetailedStatisticsUnit;
   
   public class TechDetailedUnitGroup extends DetailedStatisticsGroupEx
   {
      
      private static const UNIT_WIDTH:int = 350;
       
      
      public function TechDetailedUnitGroup()
      {
         super();
         addEventListener(Event.RESIZE,this.onResizeHandler,true,0,true);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(Event.RESIZE,this.onResizeHandler,true);
         super.onDispose();
      }
      
      override protected function adjustUnitAt(param1:int) : DetailedStatisticsUnit
      {
         var _loc2_:DetailedStatisticsUnit = super.adjustUnitAt(param1);
         _loc2_.width = UNIT_WIDTH;
         return _loc2_;
      }
      
      private function onResizeHandler(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         dispatchEvent(new Event(Event.RESIZE,true));
      }
   }
}
