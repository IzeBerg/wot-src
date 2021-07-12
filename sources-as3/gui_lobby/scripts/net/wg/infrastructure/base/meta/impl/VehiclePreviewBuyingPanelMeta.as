package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehiclePreview.data.VPBuyingPanelVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPCouponVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPOfferVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPSetItemsVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPSetVehiclesVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class VehiclePreviewBuyingPanelMeta extends BaseDAAPIComponent
   {
       
      
      public var onBuyOrResearchClick:Function;
      
      public var onCarouselVehicleSelected:Function;
      
      public var onOfferSelected:Function;
      
      public var showTooltip:Function;
      
      public var updateData:Function;
      
      public var onCouponSelected:Function;
      
      private var _vPBuyingPanelVO:VPBuyingPanelVO;
      
      private var _vPSetItemsVO:VPSetItemsVO;
      
      private var _vPCouponVO:VPCouponVO;
      
      private var _vPSetVehiclesVO:VPSetVehiclesVO;
      
      private var _dataProviderVPOfferVO:DataProvider;
      
      public function VehiclePreviewBuyingPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:VPOfferVO = null;
         if(this._vPBuyingPanelVO)
         {
            this._vPBuyingPanelVO.dispose();
            this._vPBuyingPanelVO = null;
         }
         if(this._vPSetItemsVO)
         {
            this._vPSetItemsVO.dispose();
            this._vPSetItemsVO = null;
         }
         if(this._vPCouponVO)
         {
            this._vPCouponVO.dispose();
            this._vPCouponVO = null;
         }
         if(this._vPSetVehiclesVO)
         {
            this._vPSetVehiclesVO.dispose();
            this._vPSetVehiclesVO = null;
         }
         if(this._dataProviderVPOfferVO)
         {
            for each(_loc1_ in this._dataProviderVPOfferVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderVPOfferVO.cleanUp();
            this._dataProviderVPOfferVO = null;
         }
         super.onDispose();
      }
      
      public function onBuyOrResearchClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBuyOrResearchClick,"onBuyOrResearchClick" + Errors.CANT_NULL);
         this.onBuyOrResearchClick();
      }
      
      public function onCarouselVehicleSelectedS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onCarouselVehicleSelected,"onCarouselVehicleSelected" + Errors.CANT_NULL);
         this.onCarouselVehicleSelected(param1);
      }
      
      public function onOfferSelectedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onOfferSelected,"onOfferSelected" + Errors.CANT_NULL);
         this.onOfferSelected(param1);
      }
      
      public function showTooltipS(param1:String, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.showTooltip,"showTooltip" + Errors.CANT_NULL);
         this.showTooltip(param1,param2);
      }
      
      public function updateDataS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.updateData,"updateData" + Errors.CANT_NULL);
         this.updateData(param1);
      }
      
      public function onCouponSelectedS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onCouponSelected,"onCouponSelected" + Errors.CANT_NULL);
         this.onCouponSelected(param1);
      }
      
      public final function as_setBuyData(param1:Object) : void
      {
         var _loc2_:VPBuyingPanelVO = this._vPBuyingPanelVO;
         this._vPBuyingPanelVO = new VPBuyingPanelVO(param1);
         this.setBuyData(this._vPBuyingPanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setSetItemsData(param1:Object) : void
      {
         var _loc2_:VPSetItemsVO = this._vPSetItemsVO;
         this._vPSetItemsVO = new VPSetItemsVO(param1);
         this.setSetItemsData(this._vPSetItemsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setCoupon(param1:Object) : void
      {
         var _loc2_:VPCouponVO = this._vPCouponVO;
         this._vPCouponVO = new VPCouponVO(param1);
         this.setCoupon(this._vPCouponVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setSetVehiclesData(param1:Object) : void
      {
         var _loc2_:VPSetVehiclesVO = this._vPSetVehiclesVO;
         this._vPSetVehiclesVO = new VPSetVehiclesVO(param1);
         this.setSetVehiclesData(this._vPSetVehiclesVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setOffersData(param1:Array) : void
      {
         var _loc5_:VPOfferVO = null;
         var _loc2_:DataProvider = this._dataProviderVPOfferVO;
         this._dataProviderVPOfferVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderVPOfferVO[_loc4_] = new VPOfferVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setOffersData(this._dataProviderVPOfferVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function setBuyData(param1:VPBuyingPanelVO) : void
      {
         var _loc2_:String = "as_setBuyData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setSetItemsData(param1:VPSetItemsVO) : void
      {
         var _loc2_:String = "as_setSetItemsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setCoupon(param1:VPCouponVO) : void
      {
         var _loc2_:String = "as_setCoupon" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setSetVehiclesData(param1:VPSetVehiclesVO) : void
      {
         var _loc2_:String = "as_setSetVehiclesData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setOffersData(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setOffersData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
