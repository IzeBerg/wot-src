package net.wg.gui.lobby.vehicleCompare.controls.view
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.components.controls.scroller.ScrollerBase;
   import net.wg.gui.lobby.vehicleCompare.data.VehCompareParamsDeltaVO;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class VehParamsScroller extends ScrollerBase
   {
      
      private static const SHADOW_ALPHA_WIDTH:int = 12;
       
      
      public var shadowRight:Sprite = null;
      
      private var _itemRendererFactory:Class;
      
      private var _dataProvider:IDataProvider = null;
      
      private var _rendererWidth:Number = 0;
      
      private var _measuredTypicalItemRendererWidth:Number = NaN;
      
      public function VehParamsScroller()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:VehCompareParamsViewPort = new VehCompareParamsViewPort();
         _loc1_.owner = this;
         viewPort = _loc1_;
         viewPort.mouseEnabled = false;
         container.mouseEnabled = false;
         this.shadowRight.mouseEnabled = this.shadowRight.mouseChildren = false;
         addChild(this.shadowRight);
      }
      
      override protected function onDispose() : void
      {
         viewPort.dispose();
         this._itemRendererFactory = null;
         this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
         this._dataProvider = null;
         this.shadowRight = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA))
         {
            this.dataViewPort.dataProvider = this._dataProvider;
         }
         if(isInvalid(InvalidationType.SETTINGS))
         {
            this.dataViewPort.rendererWidth = this._rendererWidth;
            this.dataViewPort.itemRendererFactory = this._itemRendererFactory;
            this._measuredTypicalItemRendererWidth = this.dataViewPort.rendererWidth;
            if(this._measuredTypicalItemRendererWidth === this._measuredTypicalItemRendererWidth)
            {
               pageWidth = this._measuredTypicalItemRendererWidth;
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.shadowRight.x = width;
            this.shadowRight.height = height;
            addChild(this.shadowRight);
         }
         super.draw();
      }
      
      public function hideDelta() : void
      {
         this.dataViewPort.hideDelta();
      }
      
      public function setParamsDelta(param1:VehCompareParamsDeltaVO) : void
      {
         this.dataViewPort.setParamsDelta(param1);
      }
      
      public function startDragging(param1:Number, param2:Number) : void
      {
         onStartDragging(param1,param2);
      }
      
      public function updateBottomLineState(param1:int, param2:Number) : void
      {
         if(viewPort)
         {
            VehCompareParamsViewPort(viewPort).updateBottomLineState(param1,param2);
         }
      }
      
      override public function set horizontalScrollPosition(param1:Number) : void
      {
         super.horizontalScrollPosition = param1 >> 0;
         this.shadowRight.alpha = Math.min((maxHorizontalScrollPosition - horizontalScrollPosition) / SHADOW_ALPHA_WIDTH,1);
         this.shadowRight.visible = this.shadowRight.alpha > 0;
      }
      
      [Inspectable(name="itemRenderer",type="String")]
      public function get itemRendererClassReference() : String
      {
         if(this._itemRendererFactory == null)
         {
            return null;
         }
         return this._itemRendererFactory.toString();
      }
      
      public function set itemRendererClassReference(param1:String) : void
      {
         if(!StringUtils.isEmpty(param1))
         {
            this._itemRendererFactory = App.instance.utils.classFactory.getClass(param1);
            invalidate(InvalidationType.SETTINGS);
         }
      }
      
      public function get dataProvider() : IDataProvider
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         if(param1 != this._dataProvider)
         {
            if(this._dataProvider)
            {
               this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            }
            this._dataProvider = param1;
            this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            invalidate(InvalidationType.DATA);
         }
      }
      
      public function get rendererWidth() : Number
      {
         return this._rendererWidth;
      }
      
      public function set rendererWidth(param1:Number) : void
      {
         if(this._rendererWidth != param1)
         {
            this._rendererWidth = param1;
            invalidate(InvalidationType.SETTINGS);
         }
      }
      
      private function get dataViewPort() : VehCompareParamsViewPort
      {
         return VehCompareParamsViewPort(this.viewPort);
      }
      
      private function onDataProviderChangeHandler(param1:Event) : void
      {
         invalidate(InvalidationType.DATA);
      }
   }
}
