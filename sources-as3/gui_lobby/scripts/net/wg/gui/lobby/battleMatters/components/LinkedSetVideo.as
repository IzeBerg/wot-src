package net.wg.gui.lobby.battleMatters.components
{
   import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
   import net.wg.gui.lobby.battleMatters.data.LinkedSetDetailsVideoVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class LinkedSetVideo extends UIComponentEx
   {
      
      private static const BTN_OFFSET:int = -20;
       
      
      public var txtHeaderService:AnimatedTextContainer = null;
      
      public var txtHeaderDepot:AnimatedTextContainer = null;
      
      public var txtHeaderEquipment:AnimatedTextContainer = null;
      
      public var txtBtnBattle:AnimatedTextContainer = null;
      
      public var txtBtnAccept:AnimatedTextContainer = null;
      
      public var txtBtnResearch:AnimatedTextContainer = null;
      
      public var txtBtnStore:AnimatedTextContainer = null;
      
      public var txtBtnShop:AnimatedTextContainer = null;
      
      public var txtBtnSell:AnimatedTextContainer = null;
      
      public var txtBtnCancel:AnimatedTextContainer = null;
      
      public var txtHeaderConfirmSale:AnimatedTextContainer = null;
      
      public var txtTotal:AnimatedTextContainer = null;
      
      public var txtHeaderPersonalReserves:AnimatedTextContainer = null;
      
      public var txtHeaderPersonalReservesSubmenu:AnimatedTextContainer = null;
      
      public var txtBtnActivateCrewDisable:AnimatedTextContainer = null;
      
      public var txtBtnActivateCrew:AnimatedTextContainer = null;
      
      public var txtBtnActivateTank:AnimatedTextContainer = null;
      
      public var txtMyProfile:AnimatedTextContainer = null;
      
      public var txtMyProfileHeader:AnimatedTextContainer = null;
      
      public var txtHeaderExterior:AnimatedTextContainer = null;
      
      public var txtBtnExterior:AnimatedTextContainer = null;
      
      public var txtBtnService:AnimatedTextContainer = null;
      
      public var txtBtnPurchase:AnimatedTextContainer = null;
      
      public var txtBtnGarage:AnimatedTextContainer = null;
      
      public var txtActivated:AnimatedTextContainer = null;
      
      public function LinkedSetVideo()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.txtHeaderService.dispose();
         this.txtHeaderDepot.dispose();
         this.txtHeaderEquipment.dispose();
         this.txtBtnBattle.dispose();
         this.txtBtnAccept.dispose();
         this.txtBtnResearch.dispose();
         this.txtBtnStore.dispose();
         this.txtBtnSell.dispose();
         this.txtBtnCancel.dispose();
         this.txtHeaderConfirmSale.dispose();
         this.txtTotal.dispose();
         this.txtHeaderPersonalReserves.dispose();
         this.txtHeaderPersonalReservesSubmenu.dispose();
         this.txtBtnActivateCrewDisable.dispose();
         this.txtBtnActivateCrew.dispose();
         this.txtBtnActivateTank.dispose();
         this.txtMyProfile.dispose();
         this.txtMyProfileHeader.dispose();
         this.txtHeaderExterior.dispose();
         this.txtBtnExterior.dispose();
         this.txtBtnService.dispose();
         this.txtBtnPurchase.dispose();
         this.txtBtnGarage.dispose();
         this.txtBtnShop.dispose();
         this.txtActivated.dispose();
         this.txtHeaderService = null;
         this.txtHeaderDepot = null;
         this.txtHeaderEquipment = null;
         this.txtBtnBattle = null;
         this.txtBtnAccept = null;
         this.txtBtnResearch = null;
         this.txtBtnStore = null;
         this.txtBtnSell = null;
         this.txtBtnCancel = null;
         this.txtHeaderConfirmSale = null;
         this.txtTotal = null;
         this.txtHeaderPersonalReserves = null;
         this.txtHeaderPersonalReservesSubmenu = null;
         this.txtBtnActivateCrewDisable = null;
         this.txtBtnActivateCrew = null;
         this.txtBtnActivateTank = null;
         this.txtMyProfile = null;
         this.txtMyProfileHeader = null;
         this.txtHeaderExterior = null;
         this.txtBtnExterior = null;
         this.txtBtnService = null;
         this.txtBtnPurchase = null;
         this.txtBtnGarage = null;
         this.txtBtnShop = null;
         this.txtActivated = null;
         super.onDispose();
      }
      
      public function setData(param1:LinkedSetDetailsVideoVO) : void
      {
         if(this.txtBtnGarage)
         {
            this.txtBtnGarage.text = this.toUpper(param1.hangarText);
         }
         if(this.txtBtnShop)
         {
            this.txtBtnShop.text = this.toUpper(param1.shopText);
         }
         if(this.txtHeaderService)
         {
            this.txtHeaderService.text = param1.headerServiceText;
         }
         if(this.txtBtnBattle)
         {
            this.txtBtnBattle.text = param1.btnBattleText;
         }
         if(this.txtBtnAccept)
         {
            this.txtBtnAccept.text = param1.btnAcceptText;
         }
         if(this.txtBtnResearch)
         {
            this.txtBtnResearch.text = param1.btnResearchText;
         }
         if(this.txtBtnStore)
         {
            this.txtBtnStore.text = this.toUpper(param1.btnStoreText);
         }
         if(this.txtHeaderDepot)
         {
            this.txtHeaderDepot.text = param1.headerDepotText;
         }
         if(this.txtBtnSell)
         {
            this.txtBtnSell.text = param1.btnSellText;
         }
         if(this.txtBtnCancel)
         {
            this.txtBtnCancel.text = param1.btnCancelText;
         }
         if(this.txtHeaderConfirmSale)
         {
            this.txtHeaderConfirmSale.text = param1.headerConfirmSaleText;
         }
         if(this.txtTotal)
         {
            this.txtTotal.text = param1.txtTotalText;
         }
         if(this.txtHeaderEquipment)
         {
            this.txtHeaderEquipment.text = param1.headerEquipmentText;
         }
         if(this.txtHeaderPersonalReserves)
         {
            this.txtHeaderPersonalReserves.text = param1.headerPersonalReservesText;
         }
         if(this.txtHeaderPersonalReservesSubmenu)
         {
            this.txtHeaderPersonalReservesSubmenu.text = param1.headerPersonalReservesText;
         }
         if(this.txtBtnActivateCrewDisable)
         {
            this.txtBtnActivateCrewDisable.text = param1.btnActivateText;
         }
         if(this.txtBtnActivateCrew)
         {
            this.txtBtnActivateCrew.text = param1.btnActivateText;
         }
         if(this.txtBtnActivateTank)
         {
            this.txtBtnActivateTank.text = param1.btnActivateText;
         }
         if(this.txtMyProfile)
         {
            this.txtMyProfile.text = param1.txtMyProfileText;
         }
         if(this.txtMyProfileHeader)
         {
            this.txtMyProfileHeader.text = param1.txtMyProfileText;
         }
         if(this.txtHeaderExterior)
         {
            this.txtHeaderExterior.text = param1.headerExteriorText;
         }
         if(this.txtBtnExterior)
         {
            this.txtBtnExterior.text = param1.btnExteriorText;
         }
         if(this.txtBtnService)
         {
            this.txtBtnService.text = param1.btnServiceText;
         }
         if(this.txtBtnPurchase)
         {
            this.txtBtnPurchase.text = param1.btnPurchaseText;
         }
         if(this.txtActivated)
         {
            this.txtActivated.text = param1.activated;
         }
         this.updatePosition();
      }
      
      private function toUpper(param1:String) : String
      {
         var _loc2_:String = App.utils.locale.makeString(param1);
         if(StringUtils.isNotEmpty(_loc2_))
         {
            _loc2_ = App.utils.toUpperOrLowerCase(_loc2_,true);
         }
         return _loc2_;
      }
      
      private function updatePosition() : void
      {
         if(this.txtBtnGarage && this.txtBtnShop)
         {
            this.txtBtnGarage.x = this.txtBtnShop.x - this.txtBtnGarage.contentWidth + BTN_OFFSET;
         }
      }
   }
}
