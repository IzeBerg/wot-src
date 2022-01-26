package net.wg.gui.lobby.linkedSet.components
{
   import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
   import net.wg.gui.lobby.linkedSet.data.LinkedSetDetailsVideoVO;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class LinkedSetVideo extends UIComponentEx
   {
       
      
      public var txtHeaderService:AnimatedTextContainer = null;
      
      public var txtHeaderDepot:AnimatedTextContainer = null;
      
      public var txtHeaderEquipment:AnimatedTextContainer = null;
      
      public var txtBtnBattle:AnimatedTextContainer = null;
      
      public var txtBtnAccept:AnimatedTextContainer = null;
      
      public var txtBtnResearch:AnimatedTextContainer = null;
      
      public var txtBtnStore:AnimatedTextContainer = null;
      
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
      
      public var txtHeaderExterior:AnimatedTextContainer = null;
      
      public var txtBtnExterior:AnimatedTextContainer = null;
      
      public var txtBtnService:AnimatedTextContainer = null;
      
      public var txtBtnPurchase:AnimatedTextContainer = null;
      
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
         this.txtHeaderExterior.dispose();
         this.txtBtnExterior.dispose();
         this.txtBtnService.dispose();
         this.txtBtnPurchase.dispose();
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
         this.txtHeaderExterior = null;
         this.txtBtnExterior = null;
         this.txtBtnService = null;
         this.txtBtnPurchase = null;
         super.onDispose();
      }
      
      public function setData(param1:LinkedSetDetailsVideoVO) : void
      {
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
            this.txtBtnStore.text = param1.btnStoreText;
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
      }
   }
}
