package net.wg.infrastructure.base
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   import net.wg.data.utilData.TwoDimensionalPadding;
   import net.wg.gui.components.popovers.SmartPopOverExternalLayout;
   import net.wg.infrastructure.base.meta.ISmartPopOverViewMeta;
   import net.wg.infrastructure.base.meta.impl.SmartPopOverViewMeta;
   import net.wg.infrastructure.interfaces.IWrapper;
   
   public class SmartPopOverView extends SmartPopOverViewMeta implements ISmartPopOverViewMeta
   {
       
      
      private var _popoverLayout:SmartPopOverExternalLayout;
      
      public function SmartPopOverView()
      {
         this._popoverLayout = new SmartPopOverExternalLayout();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stage.addEventListener(Event.RESIZE,this.stageResizeHandler,false,0,true);
         this.stageResizeHandler(null);
      }
      
      override public function set wrapper(param1:IWrapper) : void
      {
         super.wrapper = param1;
         this.initLayout();
      }
      
      protected function initLayout() : void
      {
         this._popoverLayout.positionKeyPointPadding = this.getKeyPointPadding();
         this.updateCallerGlobalPosition();
         BaseViewWrapper(wrapper).layout = this._popoverLayout;
      }
      
      protected function getKeyPointPadding() : TwoDimensionalPadding
      {
         var _loc1_:DisplayObject = DisplayObject(App.popoverMgr.popoverCaller.getTargetButton());
         var _loc2_:int = _loc1_.width >> 1;
         var _loc3_:int = _loc1_.height >> 1;
         return new TwoDimensionalPadding(new Point(0,-_loc3_),new Point(_loc2_,0),new Point(0,_loc3_),new Point(-_loc2_,0));
      }
      
      protected function updateCallerGlobalPosition() : void
      {
         var _loc5_:Point = null;
         var _loc1_:DisplayObject = DisplayObject(App.popoverMgr.popoverCaller.getTargetButton());
         var _loc2_:int = _loc1_.width >> 1;
         var _loc3_:int = _loc1_.height >> 1;
         var _loc4_:Point = new Point(_loc1_.x,_loc1_.y);
         if(_loc1_ is BackportPopOverCaller)
         {
            _loc5_ = new Point(_loc4_.x * App.appScale,_loc4_.y * App.appScale);
         }
         else
         {
            _loc5_ = _loc1_.parent.localToGlobal(_loc4_);
         }
         this.as_setPositionKeyPoint((_loc5_.x / App.appScale >> 0) + _loc2_,(_loc5_.y / App.appScale >> 0) + _loc3_);
      }
      
      private function stageResizeHandler(param1:Event) : void
      {
         this._popoverLayout.stageDimensions = new Point(App.stage.stageWidth / App.appScale >> 0,App.stage.stageHeight / App.appScale >> 0);
         this.updateCallerGlobalPosition();
         BaseViewWrapper(wrapper).invalidateLayout();
      }
      
      public function as_setPositionKeyPoint(param1:Number, param2:Number) : void
      {
         this._popoverLayout.positionKeyPoint = new Point(param1,param2);
         BaseViewWrapper(wrapper).invalidateLayout();
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(Event.RESIZE,this.stageResizeHandler);
         this._popoverLayout = null;
         super.onDispose();
      }
      
      public function get popoverLayout() : SmartPopOverExternalLayout
      {
         return this._popoverLayout;
      }
   }
}
