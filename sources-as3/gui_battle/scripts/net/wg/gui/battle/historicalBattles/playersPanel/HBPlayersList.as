package net.wg.gui.battle.historicalBattles.playersPanel
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.historicalBattles.playersPanel.VO.HBPlayerInfoVO;
   import net.wg.gui.battle.historicalBattles.playersPanel.events.HBPlayerListEvent;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   
   public class HBPlayersList extends BattleUIComponent
   {
      
      private static const LIST_ITEM_HEIGHT:int = 33;
      
      private static const LINKAGE:String = "HBPlayerRendererUI";
      
      private static const INV_RENDERERS_COUNT:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
       
      
      protected var container:Sprite;
      
      private var _renderersCount:uint = 0;
      
      private var _dataProvider:ListDAAPIDataProvider = null;
      
      private var _renderers:Vector.<HBPlayerRenderer>;
      
      private var _playersMap:Object;
      
      private var _isChatCommVisible:Boolean = false;
      
      private var _isPlayerSwitchingAllowed:Boolean = false;
      
      public function HBPlayersList()
      {
         this.container = new Sprite();
         this._renderers = new Vector.<HBPlayerRenderer>();
         this._playersMap = {};
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         addChild(this.container);
      }
      
      override protected function onDispose() : void
      {
         this.disposeRenderers();
         removeChild(this.container);
         this.container = null;
         if(this._dataProvider)
         {
            this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            this._dataProvider.removeEventListener(ListDataProviderEvent.UPDATE_ITEM,this.onDataProviderUpdateItemHandler);
            this._dataProvider = null;
         }
         App.utils.data.cleanupDynamicObject(this._playersMap);
         this._playersMap = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._dataProvider)
         {
            if(isInvalid(INV_RENDERERS_COUNT))
            {
               this.validateRenderersCount();
               this.validateLayout();
            }
            if(isInvalid(InvalidationType.DATA))
            {
               this.validateData();
            }
         }
      }
      
      public function getPlayerByAccountID(param1:Number) : HBPlayerRenderer
      {
         var _loc2_:HBPlayerRenderer = null;
         for each(_loc2_ in this._playersMap)
         {
            if(_loc2_.accountDBID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getPlayerRender(param1:int) : HBPlayerRenderer
      {
         if(this._playersMap.hasOwnProperty(param1.toString()))
         {
            return this._playersMap[param1];
         }
         return null;
      }
      
      private function disposeRenderers() : void
      {
         var _loc1_:HBPlayerRenderer = null;
         var _loc2_:int = this._renderers.length - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = this._renderers[_loc2_];
            this.container.removeChild(_loc1_);
            _loc1_.dispose();
            _loc2_--;
         }
         this._renderers.splice(0,this._renderers.length);
         this._renderers = null;
      }
      
      private function validateLayout() : void
      {
         var _loc3_:HBPlayerRenderer = null;
         var _loc1_:uint = this._renderers.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._renderers[_loc2_];
            _loc3_.y = _loc2_ * LIST_ITEM_HEIGHT;
            _loc2_++;
         }
         dispatchEvent(new HBPlayerListEvent(HBPlayerListEvent.SIZE_CHANGE,true));
      }
      
      private function validateData() : void
      {
         var _loc2_:HBPlayerRenderer = null;
         var _loc5_:HBPlayerInfoVO = null;
         App.utils.data.cleanupDynamicObject(this._playersMap);
         var _loc1_:Array = this._dataProvider.requestItemRange(0,this._dataProvider.length);
         var _loc3_:uint = this._renderers.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc1_[_loc4_];
            _loc2_ = this._renderers[_loc4_];
            this._playersMap[_loc5_.vehicleID] = _loc2_;
            _loc2_.data = _loc5_;
            _loc2_.isChatCommVisibilityEnabled = this._isChatCommVisible;
            _loc2_.isPlayerSwitchingAllowed = this._isPlayerSwitchingAllowed;
            _loc4_++;
         }
      }
      
      private function validateRenderersCount() : void
      {
         var _loc2_:HBPlayerRenderer = null;
         var _loc1_:int = this._renderers.length;
         var _loc3_:uint = this._renderersCount;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = App.utils.classFactory.getComponent(LINKAGE,HBPlayerRenderer);
            this.container.addChild(_loc2_);
            this._renderers.push(_loc2_);
            _loc1_++;
         }
         _loc1_ = this._renderers.length - 1;
         while(_loc1_ >= _loc3_)
         {
            _loc2_ = this._renderers[_loc1_];
            _loc2_.dispose();
            this.container.removeChild(_loc2_);
            this._renderers.splice(_loc1_,1);
            _loc1_--;
         }
      }
      
      public function set isChatCommVisible(param1:Boolean) : void
      {
         var _loc2_:HBPlayerRenderer = null;
         if(this._isChatCommVisible == param1)
         {
            return;
         }
         this._isChatCommVisible = param1;
         for each(_loc2_ in this._renderers)
         {
            _loc2_.isChatCommVisibilityEnabled = this._isChatCommVisible;
         }
      }
      
      public function set isPlayerSwitchingAllowed(param1:Boolean) : void
      {
         var _loc2_:HBPlayerRenderer = null;
         if(this._isPlayerSwitchingAllowed == param1)
         {
            return;
         }
         this._isPlayerSwitchingAllowed = param1;
         for each(_loc2_ in this._renderers)
         {
            _loc2_.isPlayerSwitchingAllowed = this._isPlayerSwitchingAllowed;
         }
      }
      
      public function set dataProvider(param1:ListDAAPIDataProvider) : void
      {
         if(this._dataProvider == param1)
         {
            return;
         }
         if(this._dataProvider)
         {
            this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            this._dataProvider.removeEventListener(ListDataProviderEvent.UPDATE_ITEM,this.onDataProviderUpdateItemHandler);
         }
         this._dataProvider = param1;
         this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
         this._dataProvider.addEventListener(ListDataProviderEvent.UPDATE_ITEM,this.onDataProviderUpdateItemHandler);
         this.renderersCount = this._dataProvider.length;
         invalidateData();
      }
      
      protected function set renderersCount(param1:uint) : void
      {
         if(this._renderersCount == param1)
         {
            return;
         }
         this._renderersCount = param1;
         invalidate(INV_RENDERERS_COUNT);
      }
      
      private function onDataProviderChangeHandler(param1:Event) : void
      {
         this.renderersCount = this._dataProvider.length;
         invalidateData();
      }
      
      private function onDataProviderUpdateItemHandler(param1:ListDataProviderEvent) : void
      {
         var _loc2_:HBPlayerInfoVO = HBPlayerInfoVO(param1.data);
         var _loc3_:HBPlayerRenderer = this._renderers[param1.index];
         delete this._playersMap[_loc3_.vehicleID];
         this._playersMap[_loc2_.vehicleID] = _loc3_;
         _loc3_.data = param1.data;
      }
   }
}
