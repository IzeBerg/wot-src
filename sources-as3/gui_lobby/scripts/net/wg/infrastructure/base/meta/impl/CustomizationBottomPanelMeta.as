package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.TankCarouselFilterSelectedVO;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleCustomization.data.BottomPanelVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationBottomPanelInitVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationBottomPanelNotificationVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSwitcherVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationTabNavigatorVO;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselDataVO;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselFilterVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CustomizationBottomPanelMeta extends BaseDAAPIComponent
   {
       
      
      public var resetFilter:Function;
      
      public var showBuyWindow:Function;
      
      public var refreshFilterData:Function;
      
      public var onSelectItem:Function;
      
      public var onEditItem:Function;
      
      public var showGroupFromTab:Function;
      
      public var onSelectHotFilter:Function;
      
      public var switchMode:Function;
      
      public var returnToStyledMode:Function;
      
      public var onItemIsNewAnimationShown:Function;
      
      private var _customizationBottomPanelInitVO:CustomizationBottomPanelInitVO;
      
      private var _customizationSwitcherVO:CustomizationSwitcherVO;
      
      private var _customizationTabNavigatorVO:CustomizationTabNavigatorVO;
      
      private var _array:Array;
      
      private var _customizationCarouselDataVO:CustomizationCarouselDataVO;
      
      private var _customizationCarouselFilterVO:CustomizationCarouselFilterVO;
      
      private var _bottomPanelVO:BottomPanelVO;
      
      private var _tankCarouselFilterSelectedVO:TankCarouselFilterSelectedVO;
      
      private var _customizationBottomPanelNotificationVO:CustomizationBottomPanelNotificationVO;
      
      public function CustomizationBottomPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._customizationBottomPanelInitVO)
         {
            this._customizationBottomPanelInitVO.dispose();
            this._customizationBottomPanelInitVO = null;
         }
         if(this._customizationSwitcherVO)
         {
            this._customizationSwitcherVO.dispose();
            this._customizationSwitcherVO = null;
         }
         if(this._customizationTabNavigatorVO)
         {
            this._customizationTabNavigatorVO.dispose();
            this._customizationTabNavigatorVO = null;
         }
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         if(this._customizationCarouselDataVO)
         {
            this._customizationCarouselDataVO.dispose();
            this._customizationCarouselDataVO = null;
         }
         if(this._customizationCarouselFilterVO)
         {
            this._customizationCarouselFilterVO.dispose();
            this._customizationCarouselFilterVO = null;
         }
         if(this._bottomPanelVO)
         {
            this._bottomPanelVO.dispose();
            this._bottomPanelVO = null;
         }
         if(this._tankCarouselFilterSelectedVO)
         {
            this._tankCarouselFilterSelectedVO.dispose();
            this._tankCarouselFilterSelectedVO = null;
         }
         if(this._customizationBottomPanelNotificationVO)
         {
            this._customizationBottomPanelNotificationVO.dispose();
            this._customizationBottomPanelNotificationVO = null;
         }
         super.onDispose();
      }
      
      public function resetFilterS() : void
      {
         App.utils.asserter.assertNotNull(this.resetFilter,"resetFilter" + Errors.CANT_NULL);
         this.resetFilter();
      }
      
      public function showBuyWindowS() : void
      {
         App.utils.asserter.assertNotNull(this.showBuyWindow,"showBuyWindow" + Errors.CANT_NULL);
         this.showBuyWindow();
      }
      
      public function refreshFilterDataS() : void
      {
         App.utils.asserter.assertNotNull(this.refreshFilterData,"refreshFilterData" + Errors.CANT_NULL);
         this.refreshFilterData();
      }
      
      public function onSelectItemS(param1:int, param2:int, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectItem,"onSelectItem" + Errors.CANT_NULL);
         this.onSelectItem(param1,param2,param3);
      }
      
      public function onEditItemS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onEditItem,"onEditItem" + Errors.CANT_NULL);
         this.onEditItem(param1);
      }
      
      public function showGroupFromTabS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.showGroupFromTab,"showGroupFromTab" + Errors.CANT_NULL);
         this.showGroupFromTab(param1);
      }
      
      public function onSelectHotFilterS(param1:int, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectHotFilter,"onSelectHotFilter" + Errors.CANT_NULL);
         this.onSelectHotFilter(param1,param2);
      }
      
      public function switchModeS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.switchMode,"switchMode" + Errors.CANT_NULL);
         this.switchMode(param1);
      }
      
      public function returnToStyledModeS() : void
      {
         App.utils.asserter.assertNotNull(this.returnToStyledMode,"returnToStyledMode" + Errors.CANT_NULL);
         this.returnToStyledMode();
      }
      
      public function onItemIsNewAnimationShownS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onItemIsNewAnimationShown,"onItemIsNewAnimationShown" + Errors.CANT_NULL);
         this.onItemIsNewAnimationShown(param1);
      }
      
      public final function as_setBottomPanelInitData(param1:Object) : void
      {
         var _loc2_:CustomizationBottomPanelInitVO = this._customizationBottomPanelInitVO;
         this._customizationBottomPanelInitVO = new CustomizationBottomPanelInitVO(param1);
         this.setBottomPanelInitData(this._customizationBottomPanelInitVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setSwitchersData(param1:Object) : void
      {
         var _loc2_:CustomizationSwitcherVO = this._customizationSwitcherVO;
         this._customizationSwitcherVO = new CustomizationSwitcherVO(param1);
         this.setSwitchersData(this._customizationSwitcherVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setBottomPanelTabsData(param1:Object) : void
      {
         var _loc2_:CustomizationTabNavigatorVO = this._customizationTabNavigatorVO;
         this._customizationTabNavigatorVO = new CustomizationTabNavigatorVO(param1);
         this.setBottomPanelTabsData(this._customizationTabNavigatorVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setBottomPanelTabsPluses(param1:Array) : void
      {
         var _loc2_:Array = this._array;
         this._array = param1;
         this.setBottomPanelTabsPluses(this._array);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setCarouselData(param1:Object) : void
      {
         var _loc2_:CustomizationCarouselDataVO = this._customizationCarouselDataVO;
         this._customizationCarouselDataVO = new CustomizationCarouselDataVO(param1);
         this.setCarouselData(this._customizationCarouselDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setFilterData(param1:Object) : void
      {
         var _loc2_:CustomizationCarouselFilterVO = this._customizationCarouselFilterVO;
         this._customizationCarouselFilterVO = new CustomizationCarouselFilterVO(param1);
         this.setFilterData(this._customizationCarouselFilterVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setBottomPanelPriceState(param1:Object) : void
      {
         var _loc2_:BottomPanelVO = this._bottomPanelVO;
         this._bottomPanelVO = new BottomPanelVO(param1);
         this.setBottomPanelPriceState(this._bottomPanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setCarouselFiltersData(param1:Object) : void
      {
         var _loc2_:TankCarouselFilterSelectedVO = this._tankCarouselFilterSelectedVO;
         this._tankCarouselFilterSelectedVO = new TankCarouselFilterSelectedVO(param1);
         this.setCarouselFiltersData(this._tankCarouselFilterSelectedVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setNotificationCounters(param1:Object) : void
      {
         var _loc2_:CustomizationBottomPanelNotificationVO = this._customizationBottomPanelNotificationVO;
         this._customizationBottomPanelNotificationVO = new CustomizationBottomPanelNotificationVO(param1);
         this.setNotificationCounters(this._customizationBottomPanelNotificationVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setBottomPanelInitData(param1:CustomizationBottomPanelInitVO) : void
      {
         var _loc2_:String = "as_setBottomPanelInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setSwitchersData(param1:CustomizationSwitcherVO) : void
      {
         var _loc2_:String = "as_setSwitchersData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setBottomPanelTabsData(param1:CustomizationTabNavigatorVO) : void
      {
         var _loc2_:String = "as_setBottomPanelTabsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setBottomPanelTabsPluses(param1:Array) : void
      {
         var _loc2_:String = "as_setBottomPanelTabsPluses" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setCarouselData(param1:CustomizationCarouselDataVO) : void
      {
         var _loc2_:String = "as_setCarouselData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setFilterData(param1:CustomizationCarouselFilterVO) : void
      {
         var _loc2_:String = "as_setFilterData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setBottomPanelPriceState(param1:BottomPanelVO) : void
      {
         var _loc2_:String = "as_setBottomPanelPriceState" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setCarouselFiltersData(param1:TankCarouselFilterSelectedVO) : void
      {
         var _loc2_:String = "as_setCarouselFiltersData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setNotificationCounters(param1:CustomizationBottomPanelNotificationVO) : void
      {
         var _loc2_:String = "as_setNotificationCounters" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
