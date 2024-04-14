package net.wg.gui.lobby.battleMatters
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.lobby.battleMatters.data.BattleMattersAnimVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ILocale;
   
   public class BattleMattersAnimation extends UIComponentEx
   {
      
      private static const _locale:ILocale = App.utils.locale;
      
      private static const ITEMS:Object = {
         "btnFight":MENU.HEADERBUTTONS_BATTLE,
         "btnApply":VEH_COMPARE.VEHCONF_APPLYBTNLABEL,
         "btnCancel":VEH_COMPARE.VEHCONF_CANCELBTNLABEL,
         "textHangar":_locale.makeString(MENU.HEADERBUTTONS_HANGAR).toUpperCase(),
         "textDepot":_locale.makeString(MENU.HEADERBUTTONS_STORAGE).toUpperCase(),
         "textAll":MENU.SHOP_MENU_BATTLEBOOSTER_TARGETTYPE_ALLKIND_NAME,
         "textModules":MENU.INVENTORY_MENU_MODULE_NAME,
         "btnSell":MENU.CST_ITEM_CTX_MENU_SELL,
         "btnClose":MENU.AWARDWINDOW_CLOSEBUTTON,
         "textCommander":MENU.TRAINING_OWNERTITLE,
         "textRandomBattle":MENU.BONUSTYPE_1,
         "textTopographyBattle":MENU.HEADERBUTTONS_BATTLE_TYPES_MAPSTRAINING,
         "textTopography":MENU.HEADERBUTTONS_BATTLE_TYPES_MAPSTRAINING,
         "textScenario1":_locale.makeString(MAPS_TRAINING.RESULT_SCENARIO,{"scenario":"1"}),
         "textScenario2":_locale.makeString(MAPS_TRAINING.RESULT_SCENARIO,{"scenario":"2"}),
         "textScenario3":_locale.makeString(MAPS_TRAINING.RESULT_SCENARIO,{"scenario":"3"}),
         "textScenario4":_locale.makeString(MAPS_TRAINING.RESULT_SCENARIO,{"scenario":"4"}),
         "textCampaign":_locale.makeString(MENU.HEADERBUTTONS_PERSONALMISSIONS).toUpperCase(),
         "textMapGroup1":MAPS_TRAINING.MAPSELECTION_GROUPTITLE_0,
         "textMapGroup2":MAPS_TRAINING.MAPSELECTION_GROUPTITLE_1,
         "btnStart":PERSONAL_MISSIONS.DETAILEDVIEW_STARTBTNLABEL,
         "btnResearch":MENU.UNLOCKS_UNLOCKBUTTON,
         "textTechTree":_locale.makeString(MENU.HEADERBUTTONS_TECHTREE).toUpperCase(),
         "btnBluePrint":BATTLE_MATTERS.ANIMATIONS_BLUEPRINTS,
         "btnBack":PERSONAL_MISSIONS.PERSONALMISSIONFIRSTENTRYVIEW_DETAILEDDESCRIPTION_BTNBACK,
         "btnCreate":MENU.TRAINING_CREATE_CREATEBUTTON,
         "btnRepairs":MENU.HANGAR_AMMUNITIONPANEL_MAITENANCEBTN,
         "btnExterior":MENU.HANGAR_AMMUNITIONPANEL_TUNINGBTN,
         "btnApplyAndExit":VEHICLE_CUSTOMIZATION.WINDOW_PURCHASE_BTNAPPLY,
         "textEmblems":ITEM_TYPES.CUSTOMIZATION_PLURAL_EMBLEM,
         "textShop":_locale.makeString(MENU.HEADERBUTTONS_SHOP).toUpperCase(),
         "btnGoBuy":BATTLE_MATTERS.ANIMATIONS_SHOP,
         "btnBuy":MENU.SHOP_TABLE_BUTTONBUY,
         "btnCloseX":BATTLE_MATTERS.ANIMATIONS_CREW_CLOSE,
         "btnCrewLearn":DIALOGS.PERKLEARNCONFIRM_LEARN,
         "btnCrewCancel":DIALOGS.DIALOGTEMPLATES_CANCEL,
         "applyBooksBtn":CREW_BOOKS.BUTTONS_LEARN
      };
      
      private static const HEADER_BTN_OFFSET_X:int = 30;
      
      private static const ADDITIONAL_ELEMENTS_POSTFIX:Array = ["Disabled"];
       
      
      public var btnFight:MovieClip;
      
      public var btnApply:MovieClip;
      
      public var btnApplyDisabled:MovieClip;
      
      public var btnCancel:MovieClip;
      
      public var textNickname:MovieClip;
      
      public var textHangar:MovieClip;
      
      public var textDepot:MovieClip;
      
      public var textAll:MovieClip;
      
      public var textModules:MovieClip;
      
      public var btnSell:MovieClip;
      
      public var btnClose:MovieClip;
      
      public var textCommander:MovieClip;
      
      public var applyBooksBtn:MovieClip;
      
      public var textRandomBattle:MovieClip;
      
      public var textTopographyBattle:MovieClip;
      
      public var textTopography:MovieClip;
      
      public var textScenario1:MovieClip;
      
      public var textScenario2:MovieClip;
      
      public var textScenario3:MovieClip;
      
      public var textScenario4:MovieClip;
      
      public var textCampaign:MovieClip;
      
      public var textMapGroup1:MovieClip;
      
      public var textMapGroup2:MovieClip;
      
      public var btnStart:MovieClip;
      
      public var btnResearch:MovieClip;
      
      public var textTechTree:MovieClip;
      
      public var btnBluePrint:MovieClip;
      
      public var hintBluePrint:MovieClip;
      
      public var btnBack:MovieClip;
      
      public var btnCreate:MovieClip;
      
      public var btnRepairs:MovieClip;
      
      public var btnExterior:MovieClip;
      
      public var btnApplyAndExit:MovieClip;
      
      public var btnApplyAndExitDisabled:MovieClip;
      
      public var textEmblems:MovieClip;
      
      public var textShop:MovieClip;
      
      public var btnGoBuy:MovieClip;
      
      public var btnBuy:MovieClip;
      
      public var btnCloseX:MovieClip;
      
      public var headerBtn0:MovieClip;
      
      public var headerBtn1:MovieClip;
      
      public var headerBtn2:MovieClip;
      
      public var headerBtn3:MovieClip;
      
      public var headerBtn4:MovieClip;
      
      private var _headerBtns:Vector.<MovieClip>;
      
      public function BattleMattersAnimation()
      {
         super();
         this._headerBtns = new <MovieClip>[this.textHangar,this.headerBtn0,this.textShop,this.headerBtn1,this.textDepot,this.textCampaign,this.headerBtn2,this.textTechTree,this.headerBtn3,this.headerBtn4];
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:DisplayObject = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = ADDITIONAL_ELEMENTS_POSTFIX.length;
         for(_loc2_ in ITEMS)
         {
            this.fillElement(this[_loc2_],_loc2_);
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc1_ = this.getChildByName(_loc2_ + ADDITIONAL_ELEMENTS_POSTFIX[_loc3_]);
               if(_loc1_)
               {
                  this.fillElement(_loc1_ as MovieClip,_loc2_);
               }
               _loc3_++;
            }
         }
         if(this.textTopographyBattle && this.textTopographyBattle.textField && this.textTopographyBattle.arrow)
         {
            this.textTopographyBattle.textField.autoSize = TextFieldAutoSize.LEFT;
            this.textTopographyBattle.arrow.x = this.textTopographyBattle.textField.x + this.textTopographyBattle.textField.width | 0;
         }
         if(this.textRandomBattle && this.textRandomBattle.textField && this.textRandomBattle.arrow)
         {
            this.textRandomBattle.textField.autoSize = TextFieldAutoSize.LEFT;
            this.textRandomBattle.arrow.x = this.textRandomBattle.textField.x + this.textRandomBattle.textField.width | 0;
         }
         this.updateHeaderBtnsPosition();
      }
      
      override protected function onDispose() : void
      {
         this._headerBtns.length = 0;
         this._headerBtns = null;
         this.btnFight = null;
         this.btnApply = null;
         this.btnApplyDisabled = null;
         this.btnCancel = null;
         this.textNickname = null;
         this.textHangar = null;
         this.textDepot = null;
         this.textAll = null;
         this.textModules = null;
         this.btnSell = null;
         this.btnClose = null;
         this.textCommander = null;
         this.applyBooksBtn = null;
         this.textRandomBattle = null;
         this.textTopographyBattle = null;
         this.textTopography = null;
         this.textScenario1 = null;
         this.textScenario2 = null;
         this.textScenario3 = null;
         this.textScenario4 = null;
         this.textCampaign = null;
         this.textMapGroup1 = null;
         this.textMapGroup2 = null;
         this.btnStart = null;
         this.btnResearch = null;
         this.textTechTree = null;
         this.btnBluePrint = null;
         this.hintBluePrint = null;
         this.btnBack = null;
         this.btnCreate = null;
         this.btnRepairs = null;
         this.btnExterior = null;
         this.btnApplyAndExit = null;
         this.btnApplyAndExitDisabled = null;
         this.textEmblems = null;
         this.textShop = null;
         this.btnGoBuy = null;
         this.btnBuy = null;
         this.btnCloseX = null;
         this.headerBtn0 = null;
         this.headerBtn1 = null;
         this.headerBtn2 = null;
         this.headerBtn3 = null;
         this.headerBtn4 = null;
         super.onDispose();
      }
      
      public function setData(param1:BattleMattersAnimVO) : void
      {
         if(this.textNickname && this.textNickname.textField)
         {
            this.textNickname.textField.htmlText = param1.nickName;
         }
      }
      
      private function fillElement(param1:MovieClip, param2:String) : void
      {
         var _loc3_:TextField = null;
         if(param1 && param1.textField)
         {
            _loc3_ = param1.textField;
            _loc3_.text = ITEMS[param2];
            if(this._headerBtns.indexOf(param1) >= 0)
            {
               _loc3_.autoSize = TextFieldAutoSize.LEFT;
            }
         }
      }
      
      private function updateHeaderBtnsPosition() : void
      {
         var _loc5_:MovieClip = null;
         var _loc1_:int = 0;
         var _loc2_:int = this._headerBtns.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = this._headerBtns[_loc3_];
            if(_loc5_)
            {
               _loc1_ += _loc5_.width;
               if(_loc3_ != _loc2_ - 1 && _loc5_)
               {
                  _loc1_ += HEADER_BTN_OFFSET_X;
               }
            }
            _loc3_++;
         }
         var _loc4_:int = -_loc1_ >> 1;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = this._headerBtns[_loc3_];
            if(_loc5_)
            {
               _loc5_.x = _loc4_;
               _loc4_ += _loc5_.width + HEADER_BTN_OFFSET_X;
            }
            _loc3_++;
         }
      }
   }
}
