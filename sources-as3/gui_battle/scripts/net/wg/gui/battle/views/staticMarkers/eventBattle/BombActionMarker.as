package net.wg.gui.battle.views.staticMarkers.eventBattle
{
   public class BombActionMarker extends IndexedActionMarker
   {
       
      
      public function BombActionMarker()
      {
         super();
      }
      
      public function setIsCaptured(param1:Boolean) : void
      {
         var _loc2_:IndexedContent = getContent();
         if(_loc2_ is BombContent)
         {
            (_loc2_ as BombContent).setIsCaptured(param1);
         }
      }
      
      public function setBombTimer(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:IndexedContent = getContent();
         if(_loc4_ is BombContent)
         {
            (_loc4_ as BombContent).updateTime(param1,param2,param3);
         }
      }
   }
}
