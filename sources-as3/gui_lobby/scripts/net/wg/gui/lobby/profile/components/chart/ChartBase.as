package net.wg.gui.lobby.profile.components.chart
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.gui.lobby.profile.components.chart.layout.IChartLayout;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class ChartBase extends UIComponentEx
   {
      
      private static const RENDERER_CLASS_INV:String = "rendererClassInvalid";
      
      protected static const LAYOUT_INV:String = "layoutInvalid";
       
      
      private var _itemRenderer:Class;
      
      protected var _itemRendererName:String = "";
      
      private var _dataProvider:IDataProvider;
      
      protected var _renderers:Vector.<IChartItem>;
      
      private var _currentLayout:IChartLayout;
      
      public function ChartBase()
      {
         this._renderers = new Vector.<IChartItem>();
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(RENDERER_CLASS_INV))
         {
            while(this._renderers.length > 0)
            {
               this.removeRendererAt(this._renderers.length - 1);
            }
            invalidateData();
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateRenderers();
         }
         if(isInvalid(LAYOUT_INV) && this._currentLayout)
         {
            _loc1_ = 0;
            while(_loc1_ < this._renderers.length)
            {
               this._currentLayout.layout(_loc1_,this._renderers[_loc1_]);
               _loc1_++;
            }
            dispatchEvent(new Event(Event.RESIZE,true));
         }
      }
      
      protected function updateRenderers() : void
      {
         var _loc1_:IChartItem = null;
         var _loc3_:Object = null;
         while(this._renderers.length > this.getDataProviderLength())
         {
            this.removeRendererAt(this._renderers.length - 1);
         }
         var _loc2_:uint = this.getDataProviderLength();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this._dataProvider[_loc4_];
            if(_loc4_ == this._renderers.length)
            {
               if(!this._itemRenderer)
               {
                  return;
               }
               _loc1_ = this.createRenderer();
               invalidate(LAYOUT_INV);
            }
            else
            {
               _loc1_ = this._renderers[_loc4_];
            }
            _loc1_.setData(_loc3_);
            _loc4_++;
         }
      }
      
      private function removeRendererAt(param1:uint) : void
      {
         var _loc2_:IChartItem = this._renderers.splice(param1,1)[0];
         var _loc3_:DisplayObject = DisplayObject(_loc2_);
         _loc3_.parent.removeChild(_loc3_);
         if(_loc2_ is IDisposable)
         {
            IDisposable(_loc2_).dispose();
         }
         _loc2_ = null;
      }
      
      private function createRenderer() : IChartItem
      {
         var _loc1_:IChartItem = new this._itemRenderer();
         this._renderers.push(_loc1_);
         addChild(DisplayObject(_loc1_));
         return _loc1_;
      }
      
      private function getDataProviderLength() : int
      {
         if(this._dataProvider)
         {
            return this._dataProvider.length;
         }
         return 0;
      }
      
      public function get itemRenderer() : Class
      {
         return this._itemRenderer;
      }
      
      public function set itemRenderer(param1:Class) : void
      {
         this._itemRenderer = param1;
         invalidate(RENDERER_CLASS_INV);
      }
      
      [Inspectable(name="itemRenderer")]
      public function get itemRendererName() : String
      {
         return this._itemRendererName;
      }
      
      public function set itemRendererName(param1:String) : void
      {
         var _loc2_:Class = null;
         if(_inspector && param1 == "" || param1 == "")
         {
            return;
         }
         this._itemRendererName = param1;
         _loc2_ = App.utils.classFactory.getClass(param1);
         if(_loc2_ != null)
         {
            this.itemRenderer = _loc2_;
         }
      }
      
      public function get dataProvider() : IDataProvider
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         if(this._dataProvider == param1)
         {
            return;
         }
         if(this._dataProvider != null)
         {
            this._dataProvider.removeEventListener(Event.CHANGE,this.handleDataChange,false);
         }
         this._dataProvider = param1;
         if(this._dataProvider == null)
         {
            return;
         }
         this._dataProvider.addEventListener(Event.CHANGE,this.handleDataChange,false,0,true);
         invalidateData();
      }
      
      protected function handleDataChange(param1:Event) : void
      {
         invalidate(InvalidationType.DATA);
      }
      
      public function get currentLayout() : IChartLayout
      {
         return this._currentLayout;
      }
      
      public function set currentLayout(param1:IChartLayout) : void
      {
         this._currentLayout = param1;
         invalidate(LAYOUT_INV);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Object = null;
         if(this._currentLayout)
         {
            this._currentLayout.dispose();
            this._currentLayout = null;
         }
         this._itemRenderer = null;
         super.onDispose();
         while(this._renderers.length > 0)
         {
            _loc1_ = this._renderers.splice(this._renderers.length - 1,1)[0];
            try
            {
               _loc1_.dispose();
            }
            catch(e:Error)
            {
            }
            _loc1_ = null;
         }
         if(this._dataProvider)
         {
            this._dataProvider = null;
         }
      }
   }
}
