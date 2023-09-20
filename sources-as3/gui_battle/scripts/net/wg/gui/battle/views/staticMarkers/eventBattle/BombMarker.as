package net.wg.gui.battle.views.staticMarkers.eventBattle
{
   public class BombMarker extends IndexedMarker
   {
       
      
      public function BombMarker()
      {
         super();
      }
      
      public function setIsCaptured(param1:Boolean) : void
      {
         var _loc2_:BombActionMarker = marker as BombActionMarker;
         if(_loc2_ != null)
         {
            _loc2_.setIsCaptured(param1);
         }
      }
      
      public function setBombTimer(param1:Number, param2:Number, param3:Number = 1) : void
      {
         var _loc4_:BombActionMarker = marker as BombActionMarker;
         if(_loc4_ != null)
         {
            _loc4_.setBombTimer(param1,param2,param3);
         }
      }
   }
}
