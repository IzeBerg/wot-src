package net.wg.gui.lobby.techtree.controls
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.WalletResourcesStatus;
   import net.wg.gui.lobby.techtree.constants.XpTypeStrings;
   import scaleform.clik.constants.InvalidationType;
   
   public class ResearchRootExperience extends ExperienceBlock
   {
      
      private static const ICON_OFFSET:int = 4;
       
      
      public var totalXPLabel:TextField;
      
      public var totalXPField:TextField;
      
      public var vehXPIcon:XPIcon;
      
      public var freeXPInTotalIcon:XPIcon;
      
      public var vehXPInTotalIcon:XPIcon;
      
      public var haveNotFreeXp:WalletResourcesStatus;
      
      private var _freeXP:Number = 0;
      
      private var _freeXPIsAvailable:Boolean = true;
      
      private var _isElite:Boolean = false;
      
      public function ResearchRootExperience()
      {
         super();
      }
      
      override public function setData(param1:Number, param2:Boolean = false) : void
      {
         super.setData(param1,param2);
         if(this._isElite == param2)
         {
            return;
         }
         this._isElite = param2;
         invalidateState();
      }
      
      override public function updateWalletStatus() : void
      {
         this._freeXPIsAvailable = !this.haveNotFreeXp.updateStatus(App.utils.voMgr.walletStatusVO.freeXpStatus);
         this.haveNotFreeXp.alertIco.visible = false;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.changeStars();
         }
      }
      
      override protected function onDispose() : void
      {
         this.vehXPIcon.dispose();
         this.vehXPIcon = null;
         this.vehXPInTotalIcon.dispose();
         this.vehXPInTotalIcon = null;
         this.freeXPInTotalIcon.dispose();
         this.freeXPInTotalIcon = null;
         this.haveNotFreeXp.dispose();
         this.haveNotFreeXp = null;
         this.totalXPField = null;
         this.totalXPLabel = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.totalXPLabel.text = MENU.RESEARCH_LABELS_TOTALXP;
         App.utils.commons.updateTextFieldSize(this.totalXPLabel,true,false);
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         if(this._freeXPIsAvailable)
         {
            this.totalXPField.text = _locale.integer(earnedXP + Math.max(0,this._freeXP));
         }
         this.totalXPField.visible = this._freeXPIsAvailable;
      }
      
      override protected function updateLayout() : void
      {
         var _loc1_:Number = NaN;
         App.utils.commons.updateTextFieldSize(vehXPField,true,false);
         App.utils.commons.updateTextFieldSize(this.totalXPField,true,false);
         _loc1_ = Math.max(vehXPField.width,!!this._freeXPIsAvailable ? Number(this.totalXPField.width) : Number(this.haveNotFreeXp.width));
         vehXPField.x = _loc1_ - vehXPField.width | 0;
         this.totalXPField.x = _loc1_ - this.totalXPField.width | 0;
         this.vehXPIcon.x = this.vehXPInTotalIcon.x = _loc1_ + FIELD_OFFSET | 0;
         this.freeXPInTotalIcon.x = this.vehXPInTotalIcon.x + ICON_OFFSET | 0;
         vehXPLabel.x = this.totalXPLabel.x = this.freeXPInTotalIcon.x + this.freeXPInTotalIcon.width + LABEL_OFFSET | 0;
      }
      
      private function changeStars() : void
      {
         var _loc1_:String = !!this._isElite ? XpTypeStrings.ELITE_XP_TYPE : XpTypeStrings.EARNED_XP_TYPE;
         this.vehXPIcon.type = _loc1_;
         this.vehXPInTotalIcon.type = this.vehXPIcon.type;
      }
      
      override public function set freeXP(param1:Number) : void
      {
         if(param1 == this._freeXP)
         {
            return;
         }
         this._freeXP = param1;
         invalidateData();
      }
   }
}
