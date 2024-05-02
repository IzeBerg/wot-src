package net.wg.gui.lobby.components
{
   import flash.geom.Point;
   import net.wg.gui.components.advanced.ContentTabBar;
   import net.wg.gui.lobby.components.data.StatisticsLabelLinkageDataVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   
   public class StatisticsBodyContainer extends UIComponentEx
   {
      
      private static const MIN_BTN_WIDTH:int = 136;
      
      private static const LAYOUT_INVALID:String = "layoutInv";
       
      
      public var bar:ContentTabBar = null;
      
      public var viewStack:ResizableViewStack = null;
      
      private var _barStartYPosition:int = 0;
      
      private var _viewStackStartYPosition:int = 0;
      
      private var _availableSize:Point;
      
      private var _data:IStatisticsBodyContainerData = null;
      
      public function StatisticsBodyContainer()
      {
         this._availableSize = new Point();
         super();
         this._barStartYPosition = this.bar.y >> 0;
         this._viewStackStartYPosition = this.viewStack.y >> 0;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.viewStack.cache = true;
         this.bar.minRendererWidth = MIN_BTN_WIDTH;
         this.bar.selectedIndex = -1;
         this.bar.addEventListener(IndexEvent.INDEX_CHANGE,this.onBarIndexChangeHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Array = null;
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = App.utils.data.vectorToArray(this._data.dataListVO);
            if(this.bar.dataProvider)
            {
               _loc3_ = this.bar.dataProvider.length;
               if(_loc3_ > 0 && _loc3_ != _loc1_.length)
               {
                  this.bar.selectedIndex = -1;
                  this.bar.removeAllRenderers();
               }
            }
            this.bar.dataProvider.cleanUp();
            this.bar.dataProvider = new DataProvider(_loc1_);
            if(this.bar.selectedIndex == -1 || _loc1_.length <= this.bar.selectedIndex)
            {
               this.bar.selectedIndex = 0;
            }
            _loc2_ = StatisticsLabelLinkageDataVO(_loc1_[this.bar.selectedIndex]).linkage;
            this.viewStack.show(_loc2_,_loc2_);
            this.updateDataAt(this.bar.selectedIndex);
         }
         if(isInvalid(LAYOUT_INVALID))
         {
            this.viewStack.setAvailableSize(this._availableSize.x,this._availableSize.y);
            this.bar.x = this._availableSize.x - this.bar.width >> 1;
            if(this.bar.dataProvider && this.bar.dataProvider.length > 1)
            {
               this.bar.visible = true;
               this.viewStack.y = this._viewStackStartYPosition;
            }
            else
            {
               this.bar.visible = false;
               this.viewStack.y = this._barStartYPosition;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.bar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onBarIndexChangeHandler);
         this.bar.dispose();
         this.bar = null;
         this._availableSize = null;
         this.viewStack.dispose();
         this.viewStack = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setAvailableSize(param1:Number, param2:Number) : void
      {
         this._availableSize.x = param1;
         this._availableSize.y = param2;
         invalidate(LAYOUT_INVALID);
      }
      
      public function setDossierData(param1:IStatisticsBodyContainerData) : void
      {
         this._data = param1;
         invalidateData();
         invalidate(LAYOUT_INVALID);
      }
      
      private function updateDataAt(param1:int) : void
      {
         this.viewStack.updateData(this._data.dataListVO[param1]);
      }
      
      public function get viewStackStartYPosition() : int
      {
         return this._viewStackStartYPosition;
      }
      
      private function onBarIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = param1.index;
         if(_loc2_ != -1 && param1.data)
         {
            _loc3_ = StatisticsLabelLinkageDataVO(param1.data).linkage;
            this.viewStack.show(_loc3_,_loc3_);
            this.updateDataAt(_loc2_);
         }
      }
   }
}
