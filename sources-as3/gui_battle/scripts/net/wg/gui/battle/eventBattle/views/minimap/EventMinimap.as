package net.wg.gui.battle.eventBattle.views.minimap
{
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.views.minimap.Minimap;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   
   public class EventMinimap extends Minimap
   {
      
      private static const SATURATION_FILTER:Array = [new ColorMatrixFilter([0.3,0.6,0.3,0,0,0.3,0.6,0.3,0,0,0.3,0.6,0.6,0,0,0,0,0,1,0])];
      
      private static const MESSAGE_OFFSET_Y:int = 8;
       
      
      private var _isDeploymentMode:Boolean = false;
      
      private var _entriesContainer:EventDeploymentMapEntriesContainer = null;
      
      private var _savedSizeIndex:int = 0;
      
      private var _savedEntriesContIndex:int = -1;
      
      public function EventMinimap()
      {
         super();
         this._entriesContainer = EventDeploymentMapEntriesContainer(entriesContainer);
         this._savedEntriesContIndex = getChildIndex(this._entriesContainer);
      }
      
      override protected function onDispose() : void
      {
         background.filters = null;
         super.onDispose();
         this._entriesContainer = null;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         background.filters = SATURATION_FILTER;
      }
      
      override protected function setForeground() : void
      {
         foreground0.imageName = BATTLEATLAS.WT_MINIMAP_B1;
         foreground1.imageName = BATTLEATLAS.WT_MINIMAP_B2;
         foreground2.imageName = BATTLEATLAS.WT_MINIMAP_B3;
         foreground3.imageName = BATTLEATLAS.WT_MINIMAP_B4;
         foreground4.imageName = BATTLEATLAS.WT_MINIMAP_B5;
         foreground5.imageName = BATTLEATLAS.WT_MINIMAP_B6;
      }
      
      override public function getRectangles() : Vector.<Rectangle>
      {
         if(!visible || this._isDeploymentMode)
         {
            return null;
         }
         return new <Rectangle>[mapHit.getBounds(App.stage)];
      }
      
      public function set isDeploymentMode(param1:Boolean) : void
      {
         if(this._isDeploymentMode == param1)
         {
            return;
         }
         this._isDeploymentMode = param1;
         setChildIndex(this._entriesContainer,!!this._isDeploymentMode ? int(numChildren - 1) : int(this._savedEntriesContIndex));
         this._entriesContainer.isDeploymentMode = this._isDeploymentMode;
         if(param1)
         {
            this._savedSizeIndex = currentSizeIndex;
         }
         else
         {
            currentSizeIndex = this._savedSizeIndex;
         }
         updateSizeIndex(true);
      }
      
      public function get isDeploymentMode() : Boolean
      {
         return this._isDeploymentMode;
      }
      
      override protected function updateContainersSize() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Point = null;
         _loc1_ = EventMinimapSizeConst.MAP_SIZE[currentSizeIndex];
         background.width = _loc1_.width;
         background.height = _loc1_.height;
         background.x = _loc1_.x;
         background.y = _loc1_.y;
         _loc2_ = EventMinimapSizeConst.ENTRY_CONTAINER_POINT[currentSizeIndex];
         entriesContainer.scaleX = background.scaleX;
         entriesContainer.scaleY = background.scaleY;
         MinimapEntryController.instance.updateScale(currentSizeIndex);
         entriesContainer.x = _loc2_.x;
         entriesContainer.y = _loc2_.y;
         entriesContainerMask.width = _loc1_.width;
         entriesContainerMask.height = _loc1_.height;
         entriesContainerMask.x = _loc2_.x;
         entriesContainerMask.y = _loc2_.y;
         mapHit.width = _loc1_.width;
         mapHit.height = _loc1_.height;
         mapHit.x = _loc1_.x;
         mapHit.y = _loc1_.y;
         minimapHint.x = _loc1_.x;
         minimapHint.y = _loc1_.y;
      }
      
      override public function get currentTopLeftPoint() : Point
      {
         var _loc1_:Rectangle = EventMinimapSizeConst.MAP_SIZE[currentSizeIndex];
         return _loc1_.topLeft;
      }
      
      override public function getMinimapRectBySizeIndex(param1:int) : Rectangle
      {
         var _loc2_:int = currentSizeIndex;
         if(param1 >= 0 && param1 < EventMinimapSizeConst.MAP_SIZE.length)
         {
            _loc2_ = param1;
         }
         return new Rectangle(0,0,initedWidth - EventMinimapSizeConst.MAP_SIZE[_loc2_].x,initedHeight - EventMinimapSizeConst.MAP_SIZE[_loc2_].y);
      }
      
      override public function get currentWidth() : int
      {
         var _loc1_:int = EventMinimapSizeConst.MINIMAP_MARGIN_RIGHT[currentSizeIndex];
         return super.currentWidth - _loc1_;
      }
      
      override public function getMessageCoordinate() : Number
      {
         return super.getMessageCoordinate() + MESSAGE_OFFSET_Y;
      }
   }
}
