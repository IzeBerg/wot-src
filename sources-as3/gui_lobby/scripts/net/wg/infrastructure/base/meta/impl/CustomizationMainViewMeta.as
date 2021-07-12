package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorInitVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorsSetVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorsStateVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationHeaderVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSlotIdVO;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.data.seasonBar.CustomizationSeasonBarRendererVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class CustomizationMainViewMeta extends AbstractView
   {
       
      
      public var showBuyWindow:Function;
      
      public var onCloseWindow:Function;
      
      public var fadeOutAnchors:Function;
      
      public var changeSeason:Function;
      
      public var onLobbyClick:Function;
      
      public var onSelectAnchor:Function;
      
      public var onHoverAnchor:Function;
      
      public var onDragAnchor:Function;
      
      public var onReleaseItem:Function;
      
      public var onAnchorsShown:Function;
      
      public var propertiesSheetSet:Function;
      
      public var onPressClearBtn:Function;
      
      public var onPressEscBtn:Function;
      
      public var onPressSelectNextItem:Function;
      
      public var playCustomSound:Function;
      
      public var onRemoveSelectedItem:Function;
      
      public var resetC11nItemsNovelty:Function;
      
      public var onProgressionEntryPointClick:Function;
      
      private var _customizationHeaderVO:CustomizationHeaderVO;
      
      private var _customizationAnchorInitVO:CustomizationAnchorInitVO;
      
      private var _customizationAnchorInitVO1:CustomizationAnchorInitVO;
      
      private var _customizationSlotIdVO:CustomizationSlotIdVO;
      
      private var _customizationSlotIdVO1:CustomizationSlotIdVO;
      
      private var _customizationAnchorsSetVO:CustomizationAnchorsSetVO;
      
      private var _dataProviderCustomizationSeasonBarRendererVO:DataProvider;
      
      private var _customizationCarouselRendererVO:CustomizationCarouselRendererVO;
      
      private var _array2:Array;
      
      private var _customizationAnchorsStateVO:CustomizationAnchorsStateVO;
      
      private var _customizationCarouselRendererVO1:CustomizationCarouselRendererVO;
      
      public function CustomizationMainViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:CustomizationSeasonBarRendererVO = null;
         if(this._customizationHeaderVO)
         {
            this._customizationHeaderVO.dispose();
            this._customizationHeaderVO = null;
         }
         if(this._customizationAnchorInitVO)
         {
            this._customizationAnchorInitVO.dispose();
            this._customizationAnchorInitVO = null;
         }
         if(this._customizationAnchorInitVO1)
         {
            this._customizationAnchorInitVO1.dispose();
            this._customizationAnchorInitVO1 = null;
         }
         if(this._customizationSlotIdVO)
         {
            this._customizationSlotIdVO.dispose();
            this._customizationSlotIdVO = null;
         }
         if(this._customizationSlotIdVO1)
         {
            this._customizationSlotIdVO1.dispose();
            this._customizationSlotIdVO1 = null;
         }
         if(this._customizationAnchorsSetVO)
         {
            this._customizationAnchorsSetVO.dispose();
            this._customizationAnchorsSetVO = null;
         }
         if(this._dataProviderCustomizationSeasonBarRendererVO)
         {
            for each(_loc1_ in this._dataProviderCustomizationSeasonBarRendererVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderCustomizationSeasonBarRendererVO.cleanUp();
            this._dataProviderCustomizationSeasonBarRendererVO = null;
         }
         if(this._customizationCarouselRendererVO)
         {
            this._customizationCarouselRendererVO.dispose();
            this._customizationCarouselRendererVO = null;
         }
         if(this._array2)
         {
            this._array2.splice(0,this._array2.length);
            this._array2 = null;
         }
         if(this._customizationAnchorsStateVO)
         {
            this._customizationAnchorsStateVO.dispose();
            this._customizationAnchorsStateVO = null;
         }
         if(this._customizationCarouselRendererVO1)
         {
            this._customizationCarouselRendererVO1.dispose();
            this._customizationCarouselRendererVO1 = null;
         }
         super.onDispose();
      }
      
      public function showBuyWindowS() : void
      {
         App.utils.asserter.assertNotNull(this.showBuyWindow,"showBuyWindow" + Errors.CANT_NULL);
         this.showBuyWindow();
      }
      
      public function onCloseWindowS() : void
      {
         App.utils.asserter.assertNotNull(this.onCloseWindow,"onCloseWindow" + Errors.CANT_NULL);
         this.onCloseWindow();
      }
      
      public function fadeOutAnchorsS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.fadeOutAnchors,"fadeOutAnchors" + Errors.CANT_NULL);
         this.fadeOutAnchors(param1);
      }
      
      public function changeSeasonS(param1:int, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.changeSeason,"changeSeason" + Errors.CANT_NULL);
         this.changeSeason(param1,param2);
      }
      
      public function onLobbyClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onLobbyClick,"onLobbyClick" + Errors.CANT_NULL);
         this.onLobbyClick();
      }
      
      public function onSelectAnchorS(param1:int, param2:int, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectAnchor,"onSelectAnchor" + Errors.CANT_NULL);
         this.onSelectAnchor(param1,param2,param3);
      }
      
      public function onHoverAnchorS(param1:int, param2:int, param3:int, param4:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onHoverAnchor,"onHoverAnchor" + Errors.CANT_NULL);
         this.onHoverAnchor(param1,param2,param3,param4);
      }
      
      public function onDragAnchorS(param1:int, param2:int, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.onDragAnchor,"onDragAnchor" + Errors.CANT_NULL);
         this.onDragAnchor(param1,param2,param3);
      }
      
      public function onReleaseItemS() : void
      {
         App.utils.asserter.assertNotNull(this.onReleaseItem,"onReleaseItem" + Errors.CANT_NULL);
         this.onReleaseItem();
      }
      
      public function onAnchorsShownS(param1:Array) : void
      {
         App.utils.asserter.assertNotNull(this.onAnchorsShown,"onAnchorsShown" + Errors.CANT_NULL);
         this.onAnchorsShown(param1);
      }
      
      public function propertiesSheetSetS(param1:Object, param2:int, param3:int, param4:int, param5:int) : void
      {
         App.utils.asserter.assertNotNull(this.propertiesSheetSet,"propertiesSheetSet" + Errors.CANT_NULL);
         this.propertiesSheetSet(param1,param2,param3,param4,param5);
      }
      
      public function onPressClearBtnS() : void
      {
         App.utils.asserter.assertNotNull(this.onPressClearBtn,"onPressClearBtn" + Errors.CANT_NULL);
         this.onPressClearBtn();
      }
      
      public function onPressEscBtnS() : void
      {
         App.utils.asserter.assertNotNull(this.onPressEscBtn,"onPressEscBtn" + Errors.CANT_NULL);
         this.onPressEscBtn();
      }
      
      public function onPressSelectNextItemS(param1:Boolean = false) : void
      {
         App.utils.asserter.assertNotNull(this.onPressSelectNextItem,"onPressSelectNextItem" + Errors.CANT_NULL);
         this.onPressSelectNextItem(param1);
      }
      
      public function playCustomSoundS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.playCustomSound,"playCustomSound" + Errors.CANT_NULL);
         this.playCustomSound(param1);
      }
      
      public function onRemoveSelectedItemS() : void
      {
         App.utils.asserter.assertNotNull(this.onRemoveSelectedItem,"onRemoveSelectedItem" + Errors.CANT_NULL);
         this.onRemoveSelectedItem();
      }
      
      public function resetC11nItemsNoveltyS(param1:Array) : void
      {
         App.utils.asserter.assertNotNull(this.resetC11nItemsNovelty,"resetC11nItemsNovelty" + Errors.CANT_NULL);
         this.resetC11nItemsNovelty(param1);
      }
      
      public function onProgressionEntryPointClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onProgressionEntryPointClick,"onProgressionEntryPointClick" + Errors.CANT_NULL);
         this.onProgressionEntryPointClick();
      }
      
      public final function as_setHeaderData(param1:Object) : void
      {
         var _loc2_:CustomizationHeaderVO = this._customizationHeaderVO;
         this._customizationHeaderVO = new CustomizationHeaderVO(param1);
         this.setHeaderData(this._customizationHeaderVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setAnchorInit(param1:Object) : void
      {
         var _loc2_:CustomizationAnchorInitVO = this._customizationAnchorInitVO;
         this._customizationAnchorInitVO = new CustomizationAnchorInitVO(param1);
         this.setAnchorInit(this._customizationAnchorInitVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateAnchorData(param1:Object) : void
      {
         var _loc2_:CustomizationAnchorInitVO = this._customizationAnchorInitVO1;
         this._customizationAnchorInitVO1 = new CustomizationAnchorInitVO(param1);
         this.updateAnchorData(this._customizationAnchorInitVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_onRegionHighlighted(param1:Object, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:CustomizationSlotIdVO = this._customizationSlotIdVO;
         this._customizationSlotIdVO = new CustomizationSlotIdVO(param1);
         this.onRegionHighlighted(this._customizationSlotIdVO,param2,param3,param4);
         if(_loc5_)
         {
            _loc5_.dispose();
         }
      }
      
      public final function as_updateSelectedRegions(param1:Object) : void
      {
         var _loc2_:CustomizationSlotIdVO = this._customizationSlotIdVO1;
         this._customizationSlotIdVO1 = new CustomizationSlotIdVO(param1);
         this.updateSelectedRegions(this._customizationSlotIdVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setAnchorsData(param1:Object) : void
      {
         var _loc2_:CustomizationAnchorsSetVO = this._customizationAnchorsSetVO;
         this._customizationAnchorsSetVO = new CustomizationAnchorsSetVO(param1);
         this.setAnchorsData(this._customizationAnchorsSetVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setSeasonsBarData(param1:Array) : void
      {
         var _loc5_:CustomizationSeasonBarRendererVO = null;
         var _loc2_:DataProvider = this._dataProviderCustomizationSeasonBarRendererVO;
         this._dataProviderCustomizationSeasonBarRendererVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderCustomizationSeasonBarRendererVO[_loc4_] = new CustomizationSeasonBarRendererVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setSeasonsBarData(this._dataProviderCustomizationSeasonBarRendererVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      public final function as_reselect(param1:Object) : void
      {
         var _loc2_:CustomizationCarouselRendererVO = this._customizationCarouselRendererVO;
         this._customizationCarouselRendererVO = new CustomizationCarouselRendererVO(param1);
         this.reselect(this._customizationCarouselRendererVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setNotificationCounters(param1:Array) : void
      {
         var _loc2_:Array = this._array2;
         this._array2 = param1;
         this.setNotificationCounters(this._array2);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setAnchorsState(param1:Object) : void
      {
         var _loc2_:CustomizationAnchorsStateVO = this._customizationAnchorsStateVO;
         this._customizationAnchorsStateVO = new CustomizationAnchorsStateVO(param1);
         this.setAnchorsState(this._customizationAnchorsStateVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_attachToCursor(param1:Object) : void
      {
         var _loc2_:CustomizationCarouselRendererVO = this._customizationCarouselRendererVO1;
         this._customizationCarouselRendererVO1 = new CustomizationCarouselRendererVO(param1);
         this.attachToCursor(this._customizationCarouselRendererVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setHeaderData(param1:CustomizationHeaderVO) : void
      {
         var _loc2_:String = "as_setHeaderData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setAnchorInit(param1:CustomizationAnchorInitVO) : void
      {
         var _loc2_:String = "as_setAnchorInit" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateAnchorData(param1:CustomizationAnchorInitVO) : void
      {
         var _loc2_:String = "as_updateAnchorData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function onRegionHighlighted(param1:CustomizationSlotIdVO, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:String = "as_onRegionHighlighted" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc5_);
         throw new AbstractException(_loc5_);
      }
      
      protected function updateSelectedRegions(param1:CustomizationSlotIdVO) : void
      {
         var _loc2_:String = "as_updateSelectedRegions" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setAnchorsData(param1:CustomizationAnchorsSetVO) : void
      {
         var _loc2_:String = "as_setAnchorsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setSeasonsBarData(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setSeasonsBarData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function reselect(param1:CustomizationCarouselRendererVO) : void
      {
         var _loc2_:String = "as_reselect" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setNotificationCounters(param1:Array) : void
      {
         var _loc2_:String = "as_setNotificationCounters" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setAnchorsState(param1:CustomizationAnchorsStateVO) : void
      {
         var _loc2_:String = "as_setAnchorsState" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function attachToCursor(param1:CustomizationCarouselRendererVO) : void
      {
         var _loc2_:String = "as_attachToCursor" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
