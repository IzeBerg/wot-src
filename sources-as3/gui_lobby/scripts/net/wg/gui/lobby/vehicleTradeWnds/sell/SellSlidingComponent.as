package net.wg.gui.lobby.vehicleTradeWnds.sell
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import net.wg.data.VO.SellDialogElementVO;
   import net.wg.data.VO.SellDialogItem;
   import net.wg.data.constants.generated.FITTING_TYPES;
   import net.wg.gui.events.VehicleSellDialogEvent;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellInInventoryShellVo;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellOnVehicleEquipmentVo;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellOnVehicleShellVo;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellVehicleItemBaseVo;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ILocale;
   import scaleform.clik.data.DataProvider;
   
   public class SellSlidingComponent extends UIComponentEx
   {
      
      private static const PADDING_FOR_NEXT_ELEMENT:uint = 10;
       
      
      public var settingsBtn:SettingsButton;
      
      public var mask_mc:MovieClip;
      
      public var slidingScrList:SlidingScrollingList;
      
      public var expandBg:MovieClip;
      
      public var sellData:Array;
      
      public var resultExpand:int = 0;
      
      private var _isOpened:Boolean = false;
      
      private var _listHeight:int = 0;
      
      public function SellSlidingComponent()
      {
         this.sellData = [];
         super();
         scrollRect = new Rectangle(0,0,480,270);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:SellDialogItem = null;
         var _loc2_:Vector.<SellDialogElementVO> = null;
         var _loc3_:SellDialogElementVO = null;
         this.settingsBtn.dispose();
         this.settingsBtn = null;
         this.mask_mc = null;
         this.slidingScrList.removeEventListener(VehicleSellDialogEvent.LIST_WAS_DRAWN,this.onSlidingScrListListWasDrawnHandler);
         this.slidingScrList.dispose();
         this.slidingScrList = null;
         this.expandBg = null;
         for each(_loc1_ in this.sellData)
         {
            _loc2_ = _loc1_.elements;
            for each(_loc3_ in _loc2_)
            {
               _loc3_.dispose();
            }
            _loc1_.dispose();
         }
         if(this.sellData)
         {
            this.sellData.splice(0,this.sellData.length);
            this.sellData = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.settingsBtn.visible = false;
         this.expandBg.visible = false;
         this.slidingScrList.addEventListener(VehicleSellDialogEvent.LIST_WAS_DRAWN,this.onSlidingScrListListWasDrawnHandler,false,5);
      }
      
      public function battleBoosters(param1:Vector.<SellOnVehicleEquipmentVo>) : void
      {
         var _loc3_:SellDialogItem = null;
         var _loc4_:SellOnVehicleEquipmentVo = null;
         var _loc5_:uint = 0;
         var _loc6_:SellDialogElementVO = null;
         var _loc2_:Number = param1.length;
         if(_loc2_ > 0)
         {
            _loc3_ = new SellDialogItem();
            _loc4_ = null;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc4_ = param1[_loc5_];
               _loc6_ = new SellDialogElementVO();
               _loc6_.itemIDList = [_loc4_.itemID];
               _loc6_.toInventory = _loc4_.toInventory;
               _loc6_.moneyValue = _loc4_.sellPrice[0] != 0 ? Number(_loc4_.sellPrice[0]) : Number(_loc4_.sellPrice[1]);
               _loc6_.count = _loc4_.count;
               _loc6_.onlyToInventory = _loc4_.onlyToInventory;
               _loc6_.isRemovable = true;
               _loc6_.id = _loc4_.userName;
               _loc6_.removePrice = _loc4_.removePrice;
               _loc6_.removeActionPriceVo = _loc4_.removeActionPrice;
               _loc6_.sellActionPriceVo = _loc4_.actionVo;
               _loc3_.elements.push(_loc6_);
               _loc5_++;
            }
            _loc3_.header = DIALOGS.VEHICLESELLDIALOG_BATTLEBOSTER;
            this.sellData.push(_loc3_);
         }
      }
      
      public function calculateClosedState() : void
      {
         this.settingsBtn.y = 0;
         this.slidingScrList.height = this._listHeight;
         this.slidingScrList.y = this.slidingScrList.height * -1 + this.settingsBtn.y + this.settingsBtn.height;
         this.mask_mc.y = this.settingsBtn.y + this.settingsBtn.height;
         this.mask_mc.height = 0;
      }
      
      public function calculateOpenedState() : void
      {
         this.settingsBtn.y = 0;
         this.slidingScrList.y = this.settingsBtn.y + this.settingsBtn.height;
         this.slidingScrList.height = this._listHeight;
         this.expandBg.height = this.slidingScrList.y + this._listHeight - 1;
         this.mask_mc.y = this.slidingScrList.y;
         this.mask_mc.height = this._listHeight;
      }
      
      public function getNextPosition() : int
      {
         return this.expandBg.y + this.expandBg.height + PADDING_FOR_NEXT_ELEMENT;
      }
      
      public function preInitStates() : void
      {
         this.resultExpand = this.settingsBtn.height + this._listHeight - 1 - this.expandBg.height;
      }
      
      public function setCustomization(param1:Vector.<SellOnVehicleEquipmentVo>) : void
      {
         var _loc3_:SellDialogItem = null;
         var _loc4_:SellOnVehicleEquipmentVo = null;
         var _loc5_:ILocale = null;
         var _loc6_:int = 0;
         var _loc7_:SellDialogElementVO = null;
         var _loc2_:int = param1.length;
         if(_loc2_ > 0)
         {
            _loc3_ = new SellDialogItem();
            _loc4_ = null;
            _loc5_ = App.utils.locale;
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc4_ = param1[_loc6_];
               _loc7_ = new SellDialogElementVO();
               _loc7_.itemIDList = [_loc4_.itemID];
               _loc7_.type = FITTING_TYPES.CUSTOMIZATION;
               _loc7_.toInventory = _loc4_.toInventory;
               _loc7_.moneyValue = (_loc4_.sellPrice[0] != 0 ? _loc4_.sellPrice[0] : _loc4_.sellPrice[1]) * _loc4_.count;
               _loc7_.count = _loc4_.count;
               _loc7_.onlyToInventory = _loc4_.onlyToInventory;
               _loc7_.isRemovable = true;
               _loc7_.id = _loc4_.userName + " (" + _loc4_.count + " " + _loc5_.makeString(DIALOGS.VEHICLESELLDIALOG_COUNT) + ")";
               _loc7_.removePrice = _loc4_.removePrice;
               _loc7_.removeActionPriceVo = _loc4_.removeActionPrice;
               if(_loc4_.actionVo)
               {
                  _loc7_.sellActionPriceVo = _loc4_.actionVo;
               }
               _loc3_.elements.push(_loc7_);
               _loc6_++;
            }
            _loc3_.header = DIALOGS.VEHICLESELLDIALOG_CUSTOMIZATION;
            this.sellData.push(_loc3_);
         }
         this.slidingScrList.dataProvider = new DataProvider(this.sellData);
      }
      
      public function setEquipment(param1:Vector.<SellOnVehicleEquipmentVo>) : void
      {
         var _loc3_:SellDialogItem = null;
         var _loc4_:SellOnVehicleEquipmentVo = null;
         var _loc5_:uint = 0;
         var _loc6_:SellDialogElementVO = null;
         var _loc2_:Number = param1.length;
         if(_loc2_ > 0)
         {
            _loc3_ = new SellDialogItem();
            _loc4_ = null;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc4_ = param1[_loc5_];
               _loc6_ = new SellDialogElementVO();
               _loc6_.id = _loc4_.userName;
               _loc6_.type = FITTING_TYPES.EQUIPMENT;
               _loc6_.moneyValue = _loc4_.sellPrice[0] != 0 ? Number(_loc4_.sellPrice[0]) : Number(_loc4_.sellPrice[1]);
               _loc6_.sellActionPriceVo = _loc4_.actionVo;
               _loc6_.toInventory = _loc4_.toInventory;
               _loc6_.itemIDList = [_loc4_.itemID];
               _loc6_.isRemovable = true;
               _loc6_.count = _loc4_.count;
               _loc6_.removePrice = _loc4_.removePrice;
               _loc6_.removeActionPriceVo = _loc4_.removeActionPrice;
               _loc6_.onlyToInventory = _loc4_.onlyToInventory;
               _loc3_.elements.push(_loc6_);
               _loc5_++;
            }
            _loc3_.header = DIALOGS.VEHICLESELLDIALOG_EQUIPMENT;
            this.sellData.push(_loc3_);
         }
      }
      
      public function setInventory(param1:Vector.<SellVehicleItemBaseVo>, param2:Vector.<SellInInventoryShellVo>) : void
      {
         var _loc14_:SellDialogElementVO = null;
         var _loc3_:SellDialogItem = new SellDialogItem();
         var _loc4_:Number = 0;
         var _loc5_:SellDialogElementVO = new SellDialogElementVO();
         _loc5_.toInventory = true;
         var _loc6_:Number = 0;
         var _loc7_:Number = param1.length;
         var _loc8_:SellVehicleItemBaseVo = null;
         var _loc9_:Array = [];
         var _loc10_:uint = 0;
         while(_loc10_ < _loc7_)
         {
            _loc8_ = param1[_loc10_];
            _loc4_ += _loc8_.sellPrice[0] * _loc8_.count;
            _loc6_ += _loc8_.count;
            _loc5_.toInventory = _loc5_.toInventory;
            _loc9_.push(_loc8_.itemID);
            _loc10_++;
         }
         var _loc11_:ILocale = App.utils.locale;
         if(_loc7_ > 0)
         {
            _loc5_.moneyValue = _loc4_;
            _loc5_.id = _loc11_.makeString(DIALOGS.VEHICLESELLDIALOG_NOTINSTALLED_MODULES) + " (" + _loc6_ + " " + _loc11_.makeString(DIALOGS.VEHICLESELLDIALOG_COUNT) + ")";
            _loc5_.isRemovable = true;
            _loc5_.type = FITTING_TYPES.MODULE;
            _loc5_.count = _loc6_;
            _loc5_.itemIDList = _loc9_;
            _loc5_.removePrice = _loc5_.removePrice;
            _loc5_.removeActionPriceVo = _loc8_.removeActionPrice;
            _loc3_.elements.push(_loc5_);
         }
         var _loc12_:SellInInventoryShellVo = null;
         _loc7_ = param2.length;
         var _loc13_:uint = 0;
         while(_loc13_ < _loc7_)
         {
            _loc12_ = param2[_loc13_];
            if(_loc12_.count != 0)
            {
               _loc14_ = new SellDialogElementVO();
               _loc14_.id = _loc12_.userName + " (" + _loc12_.count + " " + _loc11_.makeString(DIALOGS.VEHICLESELLDIALOG_COUNT) + ")";
               _loc14_.isRemovable = true;
               _loc14_.kind = _loc12_.kind;
               _loc14_.type = FITTING_TYPES.SHELL;
               _loc14_.toInventory = _loc12_.toInventory;
               _loc14_.fromInventory = true;
               _loc14_.itemIDList = [_loc12_.itemID];
               _loc14_.count = _loc12_.count;
               _loc14_.moneyValue = _loc12_.sellPrice[0] * _loc12_.count;
               _loc14_.onlyToInventory = _loc12_.onlyToInventory;
               _loc14_.removePrice = _loc12_.removePrice;
               _loc14_.removeActionPriceVo = _loc12_.removeActionPrice;
               if(_loc12_.actionVo)
               {
                  _loc14_.sellActionPriceVo = _loc12_.actionVo;
               }
               _loc3_.elements.push(_loc14_);
            }
            _loc13_++;
         }
         if(_loc3_.elements.length != 0)
         {
            _loc3_.header = DIALOGS.VEHICLESELLDIALOG_INVENTORY;
            this.sellData.push(_loc3_);
         }
      }
      
      public function setShells(param1:Vector.<SellOnVehicleShellVo>) : void
      {
         var _loc3_:SellDialogItem = null;
         var _loc4_:ILocale = null;
         var _loc5_:SellOnVehicleShellVo = null;
         var _loc6_:uint = 0;
         var _loc7_:SellDialogElementVO = null;
         var _loc2_:Number = param1.length;
         if(_loc2_ > 0)
         {
            _loc3_ = new SellDialogItem();
            _loc4_ = App.utils.locale;
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc5_ = param1[_loc6_];
               if(_loc5_.count != 0)
               {
                  _loc7_ = new SellDialogElementVO();
                  _loc7_.id = _loc5_.userName + " (" + _loc5_.count + " " + _loc4_.makeString(DIALOGS.VEHICLESELLDIALOG_COUNT) + ")";
                  _loc7_.isRemovable = true;
                  _loc7_.type = FITTING_TYPES.SHELL;
                  _loc7_.kind = _loc5_.kind;
                  _loc7_.itemIDList = [_loc5_.itemID];
                  _loc7_.moneyValue = _loc5_.sellPrice[0] * _loc5_.count;
                  _loc7_.fromInventory = false;
                  _loc7_.count = _loc5_.count;
                  _loc7_.onlyToInventory = _loc5_.onlyToInventory;
                  _loc7_.sellActionPriceVo = _loc5_.actionVo;
                  _loc7_.toInventory = _loc5_.toInventory;
                  _loc3_.elements.push(_loc7_);
                  _loc7_.removePrice = _loc5_.removePrice;
                  _loc7_.removeActionPriceVo = _loc5_.removeActionPrice;
               }
               _loc6_++;
            }
            if(_loc3_.elements.length != 0)
            {
               _loc3_.header = DIALOGS.VEHICLESELLDIALOG_AMMO_LABEL;
               this.sellData.push(_loc3_);
            }
         }
      }
      
      private function updateElements() : void
      {
         this.preInitStates();
         if(this.isOpened)
         {
            this.calculateOpenedState();
            this.mask_mc.visible = true;
            this.slidingScrList.visible = true;
            this.settingsBtn.creditsIT.alpha = 0;
            this.settingsBtn.ddLine.alpha = 1;
         }
         else
         {
            this.calculateClosedState();
            this.mask_mc.visible = false;
            this.slidingScrList.visible = false;
            this.settingsBtn.creditsIT.alpha = 1;
            this.settingsBtn.ddLine.alpha = 0;
         }
      }
      
      public function get isOpened() : Boolean
      {
         return this._isOpened;
      }
      
      public function set isOpened(param1:Boolean) : void
      {
         this._isOpened = param1;
         this.settingsBtn.setingsDropBtn.selected = this.isOpened;
      }
      
      private function onSlidingScrListListWasDrawnHandler(param1:VehicleSellDialogEvent) : void
      {
         this._listHeight = param1.listVisibleHight;
         this.updateElements();
      }
   }
}
