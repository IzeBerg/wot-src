package net.wg.gui.components.minimap
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.minimap.interfaces.IMinimapEntry;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.meta.IMinimapPresentationMeta;
   import net.wg.infrastructure.base.meta.impl.MinimapPresentationMeta;
   import net.wg.utils.IAssertable;
   import scaleform.clik.constants.InvalidationType;
   
   public class MinimapPresentation extends MinimapPresentationMeta implements IMinimapPresentationMeta
   {
      
      private static const MINIMAP_SIZE:int = 300;
      
      private static const POINT_SCALE_X:Number = 1.5;
      
      private static const POINT_SCALE_Y:Number = -1.5;
      
      private static const MAP_MARKER_TYPE_POINT:String = "points";
      
      private static const MAP_MARKER_TYPE_POI:String = "poi";
      
      private static const FIELD_ARENA_ID:String = "arenaID";
      
      private static const FIELD_PLAYER_TEAM:String = "playerTeam";
      
      private static const FIELD_SIZE:String = "size";
       
      
      [Inspectable(defaultValue="inRoom",enumeration="inRoom,createRoom")]
      public var scope:String = "inRoom";
      
      public var map:UILoaderAlt;
      
      public var border:MovieClip;
      
      public var grid:MovieClip;
      
      private var _size:int = 300;
      
      private var _asserter:IAssertable;
      
      public function MinimapPresentation()
      {
         this._asserter = App.utils.asserter;
         super();
      }
      
      override public function setMapS(param1:Number) : void
      {
         this._asserter.assert(!isNaN(param1),FIELD_ARENA_ID + Errors.CANT_NAN);
         super.setMapS(param1);
      }
      
      override public function setMinimapDataS(param1:int, param2:int, param3:int) : void
      {
         this._asserter.assert(!isNaN(param1),FIELD_ARENA_ID + Errors.CANT_NAN);
         this._asserter.assert(!isNaN(param2),FIELD_PLAYER_TEAM + Errors.CANT_NAN);
         this._asserter.assert(!isNaN(param3),FIELD_SIZE + Errors.CANT_NAN);
         super.setMinimapDataS(param1,param2,param3);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            iconsMask.width = iconsMask.height = this._size;
            this.grid.width = this.grid.height = this._size;
            this.map.width = this.map.height = this._size;
            icons.x = icons.y = this._size >> 1;
         }
      }
      
      override protected function onDispose() : void
      {
         this.map.removeEventListener(UILoaderEvent.COMPLETE,this.onMapCompleteHandler);
         icons.mask = null;
         this.map.dispose();
         this.map = null;
         this.clearAll();
         this.border = null;
         this.grid = null;
         this._asserter = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.grid.visible = false;
         this.border.visible = true;
         icons.mask = iconsMask;
         this.map.autoSize = false;
         this.map.addEventListener(UILoaderEvent.COMPLETE,this.onMapCompleteHandler);
      }
      
      public function as_addPoi(param1:Number, param2:Number, param3:String, param4:String) : void
      {
         var _loc5_:IMinimapEntry = this.createMinimapEntry(param1,param2);
         _loc5_.init(MAP_MARKER_TYPE_POI,param3,Values.EMPTY_STR,param4);
      }
      
      public function as_addPoint(param1:Number, param2:Number, param3:String, param4:String, param5:String) : void
      {
         var _loc6_:IMinimapEntry = this.createMinimapEntry(param1,param2);
         _loc6_.init(MAP_MARKER_TYPE_POINT,param3,param4,param5);
      }
      
      public function as_changeMap(param1:String) : void
      {
         this.map.visible = true;
         this.map.source = param1;
      }
      
      public function as_clear() : void
      {
         this.clearAll();
      }
      
      private function createMinimapEntry(param1:Number, param2:Number) : IMinimapEntry
      {
         var _loc3_:IMinimapEntry = App.utils.classFactory.getComponent(Linkages.MINIMAP_ENTRY,IMinimapEntry,{
            "x":param1,
            "y":param2,
            "scaleX":POINT_SCALE_X,
            "scaleY":POINT_SCALE_Y
         });
         var _loc4_:DisplayObject = _loc3_ as DisplayObject;
         this._asserter.assertNotNull(_loc4_,Linkages.MINIMAP_ENTRY + Errors.CANT_NULL);
         icons.addChild(_loc4_);
         return _loc3_;
      }
      
      private function clearAll() : void
      {
         while(icons.numChildren)
         {
            icons.removeChildAt(0);
         }
      }
      
      public function get size() : int
      {
         return this._size;
      }
      
      public function set size(param1:int) : void
      {
         if(param1 != this._size)
         {
            this._size = param1;
            invalidateSize();
         }
      }
      
      private function onMapCompleteHandler(param1:UILoaderEvent) : void
      {
         this.map.removeEventListener(UILoaderEvent.COMPLETE,this.onMapCompleteHandler);
         invalidateSize();
      }
   }
}
