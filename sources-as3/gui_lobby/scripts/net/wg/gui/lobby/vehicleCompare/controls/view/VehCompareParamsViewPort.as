package net.wg.gui.lobby.vehicleCompare.controls.view
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.carousels.HorizontalScrollerViewPort;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.lobby.vehicleCompare.data.VehCompareParamsDeltaVO;
   import net.wg.gui.lobby.vehicleCompare.data.VehCompareVehicleVO;
   import net.wg.gui.lobby.vehicleCompare.events.VehCompareVehParamRendererEvent;
   import net.wg.gui.lobby.vehicleCompare.interfaces.IVehParamRenderer;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehCompareParamsViewPort extends HorizontalScrollerViewPort
   {
      
      private static const ALPHA_DIST:int = 100;
      
      private static const INV_HEIGHT:String = "InvHeight";
      
      private static const INV_BOTTOM_LINE:String = "InvBottomLine";
      
      private static const INV_HOR_POS:String = "InvHorPos";
      
      private static const INV_DELTA_DATA:String = "InvDeltaData";
      
      private static const TIMER_TICK:int = 100;
       
      
      private var _bottomLinePosition:int = 0;
      
      private var _bottomLineAlpha:Number = 1;
      
      private var _currentHeight:int = -1;
      
      private var _deltaData:VehCompareParamsDeltaVO;
      
      private var _paramsDelta:VehCompareParamsDelta;
      
      private var _paramsTextField:TextField;
      
      private var _paramsRend:IScrollerItemRenderer;
      
      public function VehCompareParamsViewPort()
      {
         super();
         this._paramsDelta = new VehCompareParamsDelta();
         this._paramsDelta.visible = false;
      }
      
      private static function isTargetParam(param1:DisplayObject) : Boolean
      {
         return param1 is TextField;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(Event.RESIZE,this.onResizeHandler);
      }
      
      override protected function onDispose() : void
      {
         var _loc2_:IVehParamRenderer = null;
         if(this._paramsDelta.parent)
         {
            removeChild(this._paramsDelta);
         }
         this._paramsDelta.dispose();
         this._paramsDelta = null;
         this._deltaData = null;
         this._paramsTextField = null;
         this._paramsRend = null;
         removeEventListener(Event.RESIZE,this.onResizeHandler);
         var _loc1_:Vector.<IScrollerItemRenderer> = activeRenderers.concat(inactiveRenderers);
         for each(_loc2_ in _loc1_)
         {
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onRendClickHandler);
            _loc2_.removeEventListener(MouseEvent.MOUSE_OVER,this.onRendMouseOverHandler);
            _loc2_.removeEventListener(MouseEvent.MOUSE_OUT,this.onRendMouseOutHandler);
         }
         super.onDispose();
      }
      
      override protected function newRenderer() : IScrollerItemRenderer
      {
         var _loc1_:IVehParamRenderer = IVehParamRenderer(super.newRenderer());
         _loc1_.updateHeight(this._currentHeight);
         _loc1_.updateBottomLineState(this._bottomLinePosition,this._bottomLineAlpha);
         _loc1_.addEventListener(MouseEvent.CLICK,this.onRendClickHandler);
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.onRendMouseOverHandler);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.onRendMouseOutHandler);
         return _loc1_;
      }
      
      override protected function draw() : void
      {
         var _loc1_:IVehParamRenderer = null;
         super.draw();
         var _loc2_:Vector.<IScrollerItemRenderer> = null;
         if(this._deltaData && isInvalid(INV_DELTA_DATA))
         {
            this._paramsDelta.setData(this._deltaData);
         }
         if(isInvalid(INV_HEIGHT,INV_BOTTOM_LINE,INV_HOR_POS))
         {
            _loc2_ = activeRenderers.concat(inactiveRenderers);
         }
         if(isInvalid(INV_HEIGHT))
         {
            for each(_loc1_ in _loc2_)
            {
               _loc1_.updateHeight(this._currentHeight);
            }
         }
         if(isInvalid(INV_BOTTOM_LINE))
         {
            for each(_loc1_ in _loc2_)
            {
               _loc1_.updateBottomLineState(this._bottomLinePosition,this._bottomLineAlpha);
               _loc1_.validateNow();
            }
         }
         if(isInvalid(INV_HOR_POS))
         {
            for each(_loc1_ in activeRenderers)
            {
               _loc1_.alpha = Math.min((_loc1_.x - horizontalScrollPosition + ALPHA_DIST) / ALPHA_DIST,1);
               _loc1_.visible = _loc1_.alpha > 0;
            }
         }
         if(isInvalid(INVALIDATE_RENDERER) || isInvalid(INVALIDATE_LAYOUT_RENDERER) || isInvalid(InvalidationType.SIZE))
         {
            addChild(this._paramsDelta);
         }
      }
      
      public function hideDelta() : void
      {
         this._paramsDelta.visible = false;
      }
      
      public function setParamsDelta(param1:VehCompareParamsDeltaVO) : void
      {
         this._deltaData = param1;
         invalidate(INV_DELTA_DATA);
      }
      
      public function updateBottomLineState(param1:int, param2:Number) : void
      {
         this._bottomLinePosition = param1;
         this._bottomLineAlpha = param2;
         invalidate(INV_BOTTOM_LINE);
         validateNow();
      }
      
      private function onParamMouseOverTimerCallback() : void
      {
         var _loc1_:String = this._paramsTextField.name;
         var _loc2_:int = VehCompareVehicleVO(this._paramsRend.data).index;
         var _loc3_:VehCompareVehParamRendererEvent = new VehCompareVehParamRendererEvent(VehCompareVehParamRendererEvent.PARAM_MOUSE_OVER);
         _loc3_.paramID = _loc1_;
         _loc3_.index = _loc2_;
         dispatchEvent(_loc3_);
      }
      
      override public function set horizontalScrollPosition(param1:Number) : void
      {
         super.horizontalScrollPosition = param1;
         this._paramsDelta.updateScrollPosition(horizontalScrollPosition);
         invalidate(INV_HOR_POS);
      }
      
      private function onResizeHandler(param1:Event) : void
      {
         this._currentHeight = height;
         invalidate(INV_HEIGHT);
      }
      
      private function onRendClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:VehCompareVehParamRendererEvent = null;
         if(isTargetParam(DisplayObject(param1.target)))
         {
            _loc2_ = new VehCompareVehParamRendererEvent(VehCompareVehParamRendererEvent.PARAM_CLICK);
            _loc2_.stageY = param1.stageY;
            dispatchEvent(_loc2_);
         }
      }
      
      private function onRendMouseOutHandler(param1:MouseEvent) : void
      {
         if(isTargetParam(DisplayObject(param1.target)))
         {
            App.utils.scheduler.cancelTask(this.onParamMouseOverTimerCallback);
            dispatchEvent(new VehCompareVehParamRendererEvent(VehCompareVehParamRendererEvent.PARAM_MOUSE_OUT));
         }
      }
      
      private function onRendMouseOverHandler(param1:MouseEvent) : void
      {
         if(isTargetParam(DisplayObject(param1.target)))
         {
            this._paramsTextField = TextField(param1.target);
            this._paramsRend = IScrollerItemRenderer(param1.currentTarget);
            App.utils.scheduler.scheduleTask(this.onParamMouseOverTimerCallback,TIMER_TICK);
         }
      }
   }
}
