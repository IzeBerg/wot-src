package net.wg.gui.components.minimap
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.minimap.interfaces.IMinimapEntry;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.meta.IMinimapPresentationMeta;
   import net.wg.infrastructure.base.meta.impl.MinimapPresentationMeta;
   import net.wg.utils.IAssertable;
   import scaleform.clik.constants.InvalidationType;
   
   public class MinimapPresentation extends MinimapPresentationMeta implements IMinimapPresentationMeta
   {
      
      private static const MINIMAP_SIZE:Number = 300;
      
      private static const POINT_SCALE_X:Number = 1.5;
      
      private static const POINT_SCALE_Y:Number = -1.5;
      
      private static const MAP_MARKER_TYPE_POINT:String = "points";
       
      
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
         this._asserter.assert(!isNaN(param1),"arenaID" + Errors.CANT_NAN);
         super.setMapS(param1);
      }
      
      override public function setMinimapDataS(param1:int, param2:int, param3:int) : void
      {
         this._asserter.assert(!isNaN(param1),"arenaID" + Errors.CANT_NAN);
         this._asserter.assert(!isNaN(param2),"playerTeam" + Errors.CANT_NAN);
         this._asserter.assert(!isNaN(param3),"size" + Errors.CANT_NAN);
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
      
      public function as_addPoint(param1:Number, param2:Number, param3:String, param4:String, param5:String) : void
      {
         var _loc6_:IMinimapEntry = App.utils.classFactory.getComponent(Linkages.MINIMAP_ENTRY,IMinimapEntry,{
            "x":param1,
            "y":param2,
            "scaleX":POINT_SCALE_X,
            "scaleY":POINT_SCALE_Y
         });
         var _loc7_:DisplayObject = _loc6_ as DisplayObject;
         this._asserter.assertNotNull(_loc7_,"displayObject" + Errors.CANT_NULL);
         icons.addChild(_loc7_);
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
      
      private function clearAll() : void
      {
         while(icons.numChildren > 0)
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
