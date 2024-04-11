package net.wg.gui.battle.historicalBattles.minimap
{
   import flash.display.Sprite;
   import net.wg.gui.battle.historicalBattles.minimap.components.MapSectors;
   import net.wg.gui.battle.views.epicDeploymentMap.EpicDeploymentMap;
   
   public class HBFullMap extends EpicDeploymentMap
   {
      
      private static const MAX_STAGE_SIZE:int = 2088;
      
      private static const MAP_STAGE_PADDING:int = 30;
       
      
      public var background:Sprite = null;
      
      public var sectors:MapSectors = null;
      
      public function HBFullMap()
      {
         super();
         this.sectors.visible = false;
      }
      
      override public function as_setAlpha(param1:Number) : void
      {
      }
      
      override public function as_setBackground(param1:String) : void
      {
         mapContainer.mapHit.width = mapWidth;
         mapContainer.mapHit.height = mapHeight;
         mapContainer.mapMask.width = mapWidth;
         mapContainer.mapMask.height = mapHeight;
         HBFullMapContainer(mapContainer).init(param1,mapWidth,mapHeight);
         mapContainer.entriesContainer.x = mapWidth >> 1;
         mapContainer.entriesContainer.y = mapHeight >> 1;
      }
      
      override protected function updateLayout() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc1_:int = originalWidth < originalHeight ? int(originalWidth) : int(originalHeight);
         var _loc2_:int = _loc1_ < MAX_STAGE_SIZE ? int(_loc1_) : int(MAX_STAGE_SIZE);
         _loc3_ = _loc2_ - (MAP_STAGE_PADDING << 1);
         _loc4_ = _loc3_ / mapHeight;
         _loc5_ = _loc4_ * mapWidth;
         _loc6_ = _loc4_ * mapHeight;
         mapContainer.scaleX = _loc4_;
         mapContainer.scaleY = _loc4_;
         this.sectors.x = this.sectors.y = -MapSectors.START_SHIFT;
         this.sectors.updateSectorsSize(_loc5_);
         this.sectors.visible = true;
         _loc7_ = originalWidth - _loc5_ >> 1;
         var _loc8_:int = originalHeight - _loc6_ >> 1;
         this.x = _loc7_;
         this.y = _loc8_;
         this.background.width = originalWidth;
         this.background.height = originalHeight;
         this.background.x = -_loc7_;
         this.background.y = -_loc8_;
      }
      
      override protected function onDispose() : void
      {
         this.background = null;
         this.sectors.dispose();
         this.sectors = null;
         super.onDispose();
      }
   }
}
