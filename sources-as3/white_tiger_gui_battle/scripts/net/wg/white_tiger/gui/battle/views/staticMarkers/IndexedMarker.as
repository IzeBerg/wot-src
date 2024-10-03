package net.wg.white_tiger.gui.battle.views.staticMarkers
{
   import net.wg.gui.battle.views.staticMarkers.location.LocationMarker;
   
   public class IndexedMarker extends LocationMarker
   {
       
      
      public function IndexedMarker()
      {
         super();
      }
      
      override public function activateHover(param1:Boolean) : void
      {
         var _loc2_:IndexedActionMarker = marker as IndexedActionMarker;
         if(_loc2_)
         {
            _loc2_.setHoverVisibility(param1);
         }
      }
      
      override public function setIsStickyAndOutOfScreen(param1:Boolean) : void
      {
         super.setIsStickyAndOutOfScreen(param1);
         var _loc2_:IndexedActionMarker = marker as IndexedActionMarker;
         if(_loc2_)
         {
            _loc2_.setOutOfScreen(param1);
         }
      }
      
      public function init() : void
      {
         greenPoint.alpha = 0;
         marker.locationLineElement.alpha = 0;
      }
      
      public function playAnimation() : void
      {
         var _loc1_:IndexedActionMarker = marker as IndexedActionMarker;
         if(_loc1_)
         {
            _loc1_.playAnimation();
         }
      }
      
      public function playRepeatingAnimation() : void
      {
         var _loc1_:IndexedActionMarker = marker as IndexedActionMarker;
         if(_loc1_)
         {
            _loc1_.playRepeatingAnimation();
         }
      }
      
      public function resetGeneratorMarker() : void
      {
         var _loc1_:IndexedActionMarker = marker as IndexedActionMarker;
         if(_loc1_)
         {
            _loc1_.resetGeneratorProgress();
         }
      }
      
      public function setAlpha(param1:Number) : void
      {
         var _loc2_:IndexedActionMarker = marker as IndexedActionMarker;
         if(_loc2_)
         {
            _loc2_.setAlpha(param1);
         }
      }
      
      public function setDistance(param1:Number) : void
      {
         var _loc2_:IndexedActionMarker = marker as IndexedActionMarker;
         if(_loc2_)
         {
            _loc2_.setDistance(param1);
         }
      }
      
      public function setEntityIndex(param1:int) : void
      {
         var _loc2_:IndexedActionMarker = marker as IndexedActionMarker;
         if(_loc2_)
         {
            _loc2_.setEntityIndex(param1);
         }
      }
      
      public function setMarkerProgress(param1:Number) : void
      {
         var _loc2_:IndexedActionMarker = marker as IndexedActionMarker;
         if(_loc2_)
         {
            _loc2_.setGeneratorMarkerProgress(param1);
         }
      }
      
      public function stopAnimation() : void
      {
         var _loc1_:IndexedActionMarker = marker as IndexedActionMarker;
         if(_loc1_)
         {
            _loc1_.stopAnimation();
         }
      }
   }
}
