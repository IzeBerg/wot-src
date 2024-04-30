package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.gui.lobby.header.vo.HBC_AbstractVO;
   import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;
   import net.wg.gui.lobby.header.vo.HBC_BattleTypeVo;
   import net.wg.gui.lobby.header.vo.HBC_FinanceVo;
   import net.wg.gui.lobby.header.vo.HBC_PersonalReservesVO;
   import net.wg.gui.lobby.header.vo.HBC_PremDataVo;
   import net.wg.gui.lobby.header.vo.HBC_PremShopVO;
   import net.wg.gui.lobby.header.vo.HBC_SettingsVo;
   import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;
   import net.wg.gui.lobby.header.vo.HBC_WotPlusDataVO;
   import net.wg.gui.lobby.header.vo.HeaderButtonVo;
   import net.wg.gui.lobby.header.vo.IHBC_VO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class HeaderButtonsHelper implements IDisposable
   {
      
      public static const ITEM_ID_SETTINGS:String = "settings";
      
      public static const ITEM_ID_ACCOUNT:String = "account";
      
      public static const ITEM_ID_WOT_PLUS:String = "wotPlus";
      
      public static const ITEM_ID_PREM:String = "prem";
      
      public static const ITEM_ID_PREMSHOP:String = "premShop";
      
      public static const ITEM_ID_SQUAD:String = "squad";
      
      public static const ITEM_ID_HBSQUAD:String = "hbSquad";
      
      public static const ITEM_ID_BATTLE_SELECTOR:String = "battleSelector";
      
      public static const ITEM_ID_PERSONAL_RESERVES_WIDGET:String = "personalReservesWidget";
      
      private static const BOTTOM_HELP_DIR:String = "B";
      
      private static const BUTTONS_ORDER:Vector.<String> = new <String>[ITEM_ID_SETTINGS,ITEM_ID_ACCOUNT,ITEM_ID_WOT_PLUS,ITEM_ID_PREM,ITEM_ID_PREMSHOP,ITEM_ID_SQUAD,ITEM_ID_HBSQUAD,ITEM_ID_BATTLE_SELECTOR,ITEM_ID_PERSONAL_RESERVES_WIDGET,CURRENCIES_CONSTANTS.CRYSTAL,CURRENCIES_CONSTANTS.GOLD,CURRENCIES_CONSTANTS.CREDITS,CURRENCIES_CONSTANTS.FREE_XP];
       
      
      private var _settingsData:HeaderButtonVo;
      
      private var _accountData:HeaderButtonVo;
      
      private var _wotPlusData:HeaderButtonVo;
      
      private var _premData:HeaderButtonVo;
      
      private var _premShopData:HeaderButtonVo;
      
      private var _squadData:HeaderButtonVo;
      
      private var _hbSquadData:HeaderButtonVo;
      
      private var _battleSelectorData:HeaderButtonVo;
      
      private var _goldData:HeaderButtonVo;
      
      private var _creditsData:HeaderButtonVo;
      
      private var _crystalData:HeaderButtonVo;
      
      private var _freeXPData:HeaderButtonVo;
      
      private var _personalReservesWidgetData:HeaderButtonVo;
      
      private var _btnsMap:Object = null;
      
      private var _btnsDataProvider:DataProvider = null;
      
      private var _headerButtonBar:HeaderButtonBar = null;
      
      private var _disposed:Boolean = false;
      
      public function HeaderButtonsHelper(param1:HeaderButtonBar)
      {
         this._settingsData = new HeaderButtonVo({
            "id":ITEM_ID_SETTINGS,
            "linkage":Linkages.HBC_SETTINGS_UI,
            "direction":TextFieldAutoSize.LEFT,
            "align":TextFieldAutoSize.LEFT,
            "resizePriority":0,
            "data":new HBC_SettingsVo(),
            "helpText":LOBBY_HELP.HEADER_SETTINGS_BUTTON,
            "helpDirection":BOTTOM_HELP_DIR,
            "enabled":true
         });
         this._accountData = new HeaderButtonVo({
            "id":ITEM_ID_ACCOUNT,
            "linkage":Linkages.HBC_ACCOUNT_UI,
            "direction":TextFieldAutoSize.LEFT,
            "align":TextFieldAutoSize.LEFT,
            "resizePriority":1,
            "data":new HBC_AccountDataVo(),
            "helpText":LOBBY_HELP.HEADER_ACCOUNT_BUTTON,
            "helpDirection":BOTTOM_HELP_DIR,
            "enabled":true
         });
         this._wotPlusData = new HeaderButtonVo({
            "id":ITEM_ID_WOT_PLUS,
            "linkage":Linkages.HBC_WOT_PLUS_UI,
            "direction":TextFieldAutoSize.LEFT,
            "align":TextFieldAutoSize.LEFT,
            "resizePriority":0,
            "data":new HBC_WotPlusDataVO(),
            "helpText":LOBBY_HELP.HEADER_WOT_PLUS_BUTTON,
            "helpDirection":BOTTOM_HELP_DIR,
            "enabled":true
         });
         this._premData = new HeaderButtonVo({
            "id":ITEM_ID_PREM,
            "linkage":Linkages.HBC_PREM_UI,
            "direction":TextFieldAutoSize.LEFT,
            "align":TextFieldAutoSize.LEFT,
            "resizePriority":0,
            "data":new HBC_PremDataVo(),
            "helpText":LOBBY_HELP.HEADER_PREMIUM_BUTTON,
            "helpDirection":BOTTOM_HELP_DIR,
            "enabled":true
         });
         this._premShopData = new HeaderButtonVo({
            "id":ITEM_ID_PREMSHOP,
            "linkage":Linkages.HBC_PREM_SHOP_UI,
            "direction":TextFieldAutoSize.LEFT,
            "align":TextFieldAutoSize.LEFT,
            "resizePriority":0,
            "data":new HBC_PremShopVO(),
            "helpText":Values.EMPTY_STR,
            "helpDirection":BOTTOM_HELP_DIR,
            "enabled":true
         });
         this._squadData = new HeaderButtonVo({
            "id":ITEM_ID_SQUAD,
            "linkage":Linkages.HBC_SQUAD_UI,
            "direction":TextFieldAutoSize.LEFT,
            "align":TextFieldAutoSize.RIGHT,
            "resizePriority":0,
            "data":new HBC_SquadDataVo(),
            "helpText":LOBBY_HELP.HEADER_SQUAD_BUTTON,
            "helpDirection":BOTTOM_HELP_DIR,
            "enabled":true
         });
         this._hbSquadData = new HeaderButtonVo({
            "id":ITEM_ID_HBSQUAD,
            "linkage":Linkages.HBC_HBSQUAD_UI,
            "direction":TextFieldAutoSize.LEFT,
            "align":TextFieldAutoSize.RIGHT,
            "resizePriority":0,
            "data":new HBC_SquadDataVo(),
            "helpText":LOBBY_HELP.HEADER_SQUAD_BUTTON,
            "helpDirection":BOTTOM_HELP_DIR,
            "enabled":true
         });
         this._battleSelectorData = new HeaderButtonVo({
            "id":ITEM_ID_BATTLE_SELECTOR,
            "linkage":Linkages.HBC_BATTLE_SELECTOR_UI,
            "direction":TextFieldAutoSize.RIGHT,
            "align":TextFieldAutoSize.LEFT,
            "resizePriority":2,
            "data":new HBC_BattleTypeVo(),
            "helpText":LOBBY_HELP.HEADER_BATTLETYPE_BUTTON,
            "helpDirection":BOTTOM_HELP_DIR,
            "enabled":true
         });
         this._goldData = new HeaderButtonVo({
            "id":CURRENCIES_CONSTANTS.GOLD,
            "linkage":Linkages.HBC_FINANCE_UI,
            "direction":TextFieldAutoSize.RIGHT,
            "align":TextFieldAutoSize.RIGHT,
            "resizePriority":0,
            "data":new HBC_FinanceVo(),
            "helpText":Values.EMPTY_STR,
            "helpDirection":BOTTOM_HELP_DIR,
            "enabled":true
         });
         this._creditsData = new HeaderButtonVo({
            "id":CURRENCIES_CONSTANTS.CREDITS,
            "linkage":Linkages.HBC_FINANCE_UI,
            "direction":TextFieldAutoSize.RIGHT,
            "align":TextFieldAutoSize.RIGHT,
            "resizePriority":0,
            "data":new HBC_FinanceVo(),
            "helpText":Values.EMPTY_STR,
            "helpDirection":BOTTOM_HELP_DIR,
            "enabled":true
         });
         this._crystalData = new HeaderButtonVo({
            "id":CURRENCIES_CONSTANTS.CRYSTAL,
            "linkage":Linkages.HBC_FINANCE_UI,
            "direction":TextFieldAutoSize.RIGHT,
            "align":TextFieldAutoSize.RIGHT,
            "resizePriority":0,
            "data":new HBC_FinanceVo(),
            "helpText":Values.EMPTY_STR,
            "helpDirection":BOTTOM_HELP_DIR,
            "enabled":true
         });
         this._freeXPData = new HeaderButtonVo({
            "id":CURRENCIES_CONSTANTS.FREE_XP,
            "linkage":Linkages.HBC_FINANCE_UI,
            "direction":TextFieldAutoSize.RIGHT,
            "align":TextFieldAutoSize.RIGHT,
            "resizePriority":0,
            "data":new HBC_FinanceVo(),
            "helpText":Values.EMPTY_STR,
            "helpDirection":BOTTOM_HELP_DIR,
            "enabled":true
         });
         this._personalReservesWidgetData = new HeaderButtonVo({
            "id":ITEM_ID_PERSONAL_RESERVES_WIDGET,
            "linkage":Linkages.HBC_PERSONAL_RESERVES_UI,
            "direction":TextFieldAutoSize.RIGHT,
            "align":TextFieldAutoSize.RIGHT,
            "resizePriority":1,
            "data":new HBC_PersonalReservesVO(),
            "helpText":LOBBY_HELP.HEADER_PERSONAL_RESERVES,
            "helpDirection":BOTTOM_HELP_DIR,
            "enabled":true
         });
         super();
         this._btnsDataProvider = new DataProvider();
         this._btnsMap = {};
         this._btnsMap[this._settingsData.id] = this._settingsData;
         this._btnsMap[this._accountData.id] = this._accountData;
         this._btnsMap[this._wotPlusData.id] = this._wotPlusData;
         this._btnsMap[this._premData.id] = this._premData;
         this._btnsMap[this._premShopData.id] = this._premShopData;
         this._btnsMap[this._squadData.id] = this._squadData;
         this._btnsMap[this._hbSquadData.id] = this._hbSquadData;
         this._btnsMap[this._battleSelectorData.id] = this._battleSelectorData;
         this._btnsMap[this._personalReservesWidgetData.id] = this._personalReservesWidgetData;
         this._btnsMap[this._crystalData.id] = this._crystalData;
         this._btnsMap[this._goldData.id] = this._goldData;
         this._btnsMap[this._creditsData.id] = this._creditsData;
         this._btnsMap[this._freeXPData.id] = this._freeXPData;
         this._headerButtonBar = param1;
      }
      
      public function setupButtons(param1:Vector.<String>) : void
      {
         var _loc3_:String = null;
         var _loc4_:HeaderButtonVo = null;
         this._btnsDataProvider.cleanUp();
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            _loc4_ = this._btnsMap[_loc3_];
            _loc2_.push(_loc4_);
         }
         _loc2_.sort(this.compareVo);
         this._btnsDataProvider.setSource(_loc2_);
         this._btnsDataProvider.invalidate();
         this.invalidateAllData();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._headerButtonBar = null;
         this._settingsData.dispose();
         this._settingsData = null;
         this._accountData.dispose();
         this._accountData = null;
         this._wotPlusData.dispose();
         this._wotPlusData = null;
         this._premData.dispose();
         this._premData = null;
         this._premShopData.dispose();
         this._premShopData = null;
         this._squadData.dispose();
         this._squadData = null;
         this._hbSquadData.dispose();
         this._hbSquadData = null;
         this._battleSelectorData.dispose();
         this._battleSelectorData = null;
         this._goldData.dispose();
         this._goldData = null;
         this._creditsData.dispose();
         this._creditsData = null;
         this._crystalData.dispose();
         this._crystalData = null;
         this._freeXPData.dispose();
         this._freeXPData = null;
         this._personalReservesWidgetData.dispose();
         this._personalReservesWidgetData = null;
         App.utils.data.cleanupDynamicObject(this._btnsMap);
         this._btnsMap = null;
         this._btnsDataProvider.cleanUp();
         this._btnsDataProvider = null;
      }
      
      public function getContentDataById(param1:String) : IHBC_VO
      {
         var _loc2_:HeaderButtonVo = this._btnsMap[param1];
         return _loc2_.data;
      }
      
      public function invalidateAllData() : void
      {
         this._headerButtonBar.dataProvider = this.getHeaderDataProvider();
      }
      
      public function invalidateDataById(param1:String) : void
      {
         var _loc2_:HeaderButton = this.searchButtonById(param1);
         if(_loc2_)
         {
            _loc2_.updateContentData();
         }
      }
      
      public function setButtonEnabled(param1:String, param2:Boolean) : void
      {
         var _loc3_:HeaderButtonVo = this.getButtonDataById(param1);
         _loc3_.enabled = param2;
         if(_loc3_.headerButton)
         {
            _loc3_.headerButton.updateEnabled();
         }
      }
      
      public function setButtonSoftDisable(param1:String, param2:Boolean) : void
      {
         var _loc3_:HeaderButtonVo = this.getButtonDataById(param1);
         _loc3_.softDisable = param2;
         if(_loc3_.headerButton)
         {
            _loc3_.headerButton.updateEnabled();
         }
      }
      
      public function setContentData(param1:String, param2:HBC_AbstractVO) : void
      {
         this.getButtonDataById(param1).data = param2;
         this.invalidateDataById(param1);
      }
      
      protected function get buttonsArrData() : IDataProvider
      {
         return this._btnsDataProvider;
      }
      
      protected function getButtonDataById(param1:String) : HeaderButtonVo
      {
         return this._btnsMap[param1];
      }
      
      public function searchButtonById(param1:String) : HeaderButton
      {
         var _loc2_:HeaderButtonVo = this.getButtonDataById(param1);
         if(_loc2_ != null)
         {
            return _loc2_.headerButton;
         }
         return null;
      }
      
      public function hasDataProviderButtonById(param1:String) : Boolean
      {
         var _loc2_:HeaderButtonVo = null;
         var _loc3_:int = this._btnsDataProvider.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = HeaderButtonVo(this._btnsDataProvider[_loc4_]);
            if(_loc2_.id == param1)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      protected function getHeaderDataProvider() : IDataProvider
      {
         return this._btnsDataProvider;
      }
      
      private function compareVo(param1:HeaderButtonVo, param2:HeaderButtonVo) : int
      {
         return BUTTONS_ORDER.indexOf(param1.id) - BUTTONS_ORDER.indexOf(param2.id);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
