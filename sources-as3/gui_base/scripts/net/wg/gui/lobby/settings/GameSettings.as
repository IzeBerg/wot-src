package net.wg.gui.lobby.settings
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.text.TextFormatAlign;
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.controls.BorderShadowScrollPane;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.lobby.settings.components.LimitedUISettingBlock;
   import net.wg.gui.lobby.settings.components.evnts.LimitedUIEvent;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.gui.lobby.settings.events.SettingViewEvent;
   import net.wg.gui.lobby.settings.vo.AnonymizerExtraVO;
   import net.wg.gui.lobby.settings.vo.CheckboxVo;
   import net.wg.gui.lobby.settings.vo.DevMapsVO;
   import net.wg.gui.lobby.settings.vo.RandomXLvlVO;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.SimpleExtraVO;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterProps;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.events.SliderEvent;
   
   public class GameSettings extends SettingsBaseView
   {
      
      public static const LINKAGE:String = "GameSettings";
      
      private static const PANE_WIDTH:Number = 800;
      
      private static const PANE_HEIGHT:Number = 518;
      
      private static const SHADOW_HEIGHT:int = 20;
      
      private static const INCREASED_ZOOM_LBL:String = "increasedZoom";
      
      private static const SHOW_DAMAGE_ICON_LBL:String = "showDamageIcon";
      
      private static const ANONYMIZER:String = "anonymizer";
      
      private static const SHOW_VEHICLE_HP_IN_MINIMAP:String = "showVehicleHPinMinimap";
      
      private static const SWITCH_EQUIPMENT:String = "switchEquipment";
      
      private static const TO_STRING_MSG:String = "WG GameSettings: ";
      
      private static const GAME_COUNTER_CONTAINER_ID:String = "GAME_COUNTER_CONTAINER_ID";
      
      private static const GAME_COUNTER_LIMITED_UI_CONTROL:String = "limitedUIActive";
      
      private static const COUNTER_CHECKBOX_OFFSET_X:Number = -11;
      
      private static const BATTLE_TYPES_HEIGHT_EXTRA:int = 212;
      
      private static const LIMITED_UI_SETTING_BLOCK_X:uint = 400;
      
      private static const LIMITED_UI_SETTING_BLOCK_PADDING:uint = 80;
      
      private static const PANE_HEIGHT_WITH_LIMITED_UI_SETTING_BLOCK:uint = PANE_HEIGHT - LIMITED_UI_SETTING_BLOCK_PADDING;
       
      
      public var scrollPane:BorderShadowScrollPane;
      
      private var _limitedUISettingBlock:LimitedUISettingBlock;
      
      public function GameSettings()
      {
         super();
      }
      
      override public function toString() : String
      {
         return TO_STRING_MSG + name;
      }
      
      override protected function getContainerId() : String
      {
         return GAME_COUNTER_CONTAINER_ID;
      }
      
      override protected function getCounterProps(param1:String) : ICounterProps
      {
         if(param1 == SettingsConfigHelper.TYPE_CHECKBOX)
         {
            return new CounterProps(COUNTER_CHECKBOX_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y,TextFormatAlign.LEFT,false,Linkages.COUNTER_LINE_UI);
         }
         return super.getCounterProps(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.scrollPane.topShadow.height = this.scrollPane.bottomShadow.height = SHADOW_HEIGHT;
         this.scrollPane.setSize(PANE_WIDTH,PANE_HEIGHT);
         App.utils.asserter.assertNotNull(this.getContent(),Errors.CANT_NULL);
      }
      
      override protected function getControl(param1:String, param2:String) : DisplayObject
      {
         var _loc3_:GameSettingsContent = this.getContent();
         return _loc3_[param1 + param2];
      }
      
      override protected function setData(param1:SettingsDataVo) : void
      {
         var _loc8_:String = null;
         var _loc9_:CheckBox = null;
         var _loc10_:Boolean = false;
         var _loc14_:CheckboxVo = null;
         var _loc15_:AnonymizerExtraVO = null;
         var _loc16_:SimpleExtraVO = null;
         var _loc17_:RandomXLvlVO = null;
         var _loc18_:DevMapsVO = null;
         var _loc19_:String = null;
         var _loc2_:Vector.<String> = param1.keys;
         var _loc3_:Vector.<Object> = param1.values;
         var _loc4_:int = _loc2_.length;
         var _loc5_:String = Values.EMPTY_STR;
         var _loc6_:SettingsControlProp = null;
         var _loc7_:GameSettingsContent = this.getContent();
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:int = 0;
         while(_loc13_ < _loc4_)
         {
            _loc5_ = _loc2_[_loc13_];
            _loc6_ = _loc3_[_loc13_] as SettingsControlProp;
            App.utils.asserter.assertNotNull(_loc6_,Errors.CANT_NULL);
            _loc8_ = _loc5_ + _loc6_.type;
            if(_loc7_[_loc8_])
            {
               _loc10_ = !(_loc6_.current == null || _loc6_.readOnly);
               switch(_loc6_.type)
               {
                  case SettingsConfigHelper.TYPE_CHECKBOX:
                     _loc9_ = CheckBox(_loc7_[_loc8_]);
                     this.setupCheckBox(_loc9_,_loc6_.current,_loc10_);
                     if(_loc5_ == SettingsConfigHelper.RECEIVE_CLAN_INVITES_NOTIFICATIONS)
                     {
                        if(!_loc10_)
                        {
                           _loc9_.enabled = false;
                           _loc9_.selected = false;
                        }
                     }
                     else if(_loc5_ == SHOW_DAMAGE_ICON_LBL || _loc5_ == INCREASED_ZOOM_LBL)
                     {
                        _loc14_ = new CheckboxVo(_loc6_.extraData);
                        _loc9_.toolTip = _loc14_.tooltip;
                        _loc9_.label = _loc14_.checkBoxLabel;
                        _loc14_.dispose();
                     }
                     else if(_loc5_ == ANONYMIZER)
                     {
                        _loc15_ = new AnonymizerExtraVO(_loc6_.extraData);
                        _loc9_.label = _loc15_.checkBoxLabel;
                        _loc9_.toolTip = _loc15_.tooltip;
                        _loc9_.visible = _loc15_.visible;
                        _loc9_.enabled = _loc15_.enabled;
                        _loc15_.dispose();
                     }
                     else if(_loc5_ == SHOW_VEHICLE_HP_IN_MINIMAP || _loc5_ == SWITCH_EQUIPMENT)
                     {
                        _loc16_ = new SimpleExtraVO(_loc6_.extraData);
                        _loc9_.enabled = _loc16_.enabled;
                     }
                     else if(_loc5_ == SettingsConfigHelper.GAMEPLAY_ONLY_10_MODE)
                     {
                        _loc17_ = new RandomXLvlVO(_loc6_.extraData);
                        _loc9_.visible = _loc17_.enabled;
                        _loc11_ = _loc17_.enabled;
                     }
                     else if(_loc5_ == SettingsConfigHelper.GAMEPLAY_DEVMAPS)
                     {
                        _loc18_ = new DevMapsVO(_loc6_.extraData);
                        _loc9_.visible = _loc18_.enabled;
                        _loc12_ = _loc18_.enabled;
                     }
                     break;
                  case SettingsConfigHelper.TYPE_DROPDOWN:
                     this.setupDropDown(_loc7_[_loc8_],_loc6_,_loc10_);
                     break;
                  case SettingsConfigHelper.TYPE_SLIDER:
                     this.setupSlider(Slider(_loc7_[_loc8_]),Number(_loc6_.current),_loc10_);
                     if(_loc6_.hasValue && _loc7_[_loc5_ + SettingsConfigHelper.TYPE_VALUE])
                     {
                        this.setupLabel(_loc7_[_loc5_ + SettingsConfigHelper.TYPE_VALUE],_loc6_.current.toString());
                     }
                     break;
                  case SettingsConfigHelper.TYPE_BUTTON_BAR:
                     this.setupButtonBar(ButtonBarEx(_loc7_[_loc8_]),_loc6_,_loc10_);
                     if(_loc5_ == SettingsConfigHelper.CAROUSEL_TYPE)
                     {
                        _loc19_ = SettingsConfigHelper.CAROUSEL_TYPE_ID[_loc6_.current];
                        _loc7_.doubleCarouselTypeDropDown.enabled = _loc19_ == SettingsConfigHelper.CAROUSEL_DOUBLE;
                     }
               }
            }
            else if(!_loc6_.readOnly)
            {
               DebugUtils.LOG_WARNING(_loc8_ + Errors.CANT_NULL);
            }
            _loc13_++;
         }
         _loc7_.updateDependentVisibleControls(_loc11_,_loc12_,BATTLE_TYPES_HEIGHT_EXTRA);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:String = null;
         var _loc2_:Vector.<String> = null;
         var _loc3_:Vector.<Object> = null;
         var _loc4_:int = 0;
         var _loc5_:GameSettingsContent = null;
         var _loc6_:SettingsControlProp = null;
         var _loc7_:String = null;
         var _loc8_:CheckBox = null;
         var _loc9_:Slider = null;
         var _loc10_:DropdownMenu = null;
         var _loc11_:ButtonBarEx = null;
         var _loc12_:int = 0;
         if(data)
         {
            _loc1_ = Values.EMPTY_STR;
            _loc2_ = data.keys;
            _loc3_ = data.values;
            _loc4_ = _loc2_.length;
            _loc5_ = this.getContent();
            _loc12_ = 0;
            for(; _loc12_ < _loc4_; _loc12_++)
            {
               _loc1_ = _loc2_[_loc12_];
               _loc6_ = _loc3_[_loc12_] as SettingsControlProp;
               App.utils.asserter.assertNotNull(_loc6_,Errors.CANT_NULL);
               _loc7_ = _loc1_ + _loc6_.type;
               if(!_loc5_[_loc7_])
               {
                  continue;
               }
               switch(_loc6_.type)
               {
                  case SettingsConfigHelper.TYPE_CHECKBOX:
                     _loc8_ = _loc5_[_loc7_];
                     _loc8_.removeEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
                     break;
                  case SettingsConfigHelper.TYPE_SLIDER:
                     _loc9_ = _loc5_[_loc7_];
                     _loc9_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
                     break;
                  case SettingsConfigHelper.TYPE_DROPDOWN:
                     _loc10_ = _loc5_[_loc7_];
                     _loc10_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropdownIndexChangeHandler);
                     break;
                  case SettingsConfigHelper.TYPE_BUTTON_BAR:
                     _loc11_ = _loc5_[_loc7_];
                     _loc11_.removeEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
                     break;
               }
            }
         }
         if(this._limitedUISettingBlock)
         {
            this._limitedUISettingBlock.removeEventListener(LimitedUIEvent.TURN_OFF,this.onLimitedUITurnOffHandler);
            removeChild(this._limitedUISettingBlock);
            this._limitedUISettingBlock.dispose();
            this._limitedUISettingBlock = null;
         }
         this.scrollPane.dispose();
         this.scrollPane = null;
         super.onDispose();
      }
      
      override protected function updateNewCounter(param1:CountersVo) : Boolean
      {
         var _loc2_:ICounterProps = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:String = null;
         if(this._limitedUISettingBlock && param1.componentId == GAME_COUNTER_LIMITED_UI_CONTROL)
         {
            _loc2_ = this.getCounterProps(SettingsConfigHelper.TYPE_BUTTON);
            _loc3_ = this._limitedUISettingBlock.turnOffBtn;
            _loc4_ = !!this._limitedUISettingBlock.visible ? param1.count : Values.EMPTY_STR;
            addNewCounterControl(_loc3_,_loc4_,_loc2_,false);
            return true;
         }
         return super.updateNewCounter(param1);
      }
      
      override protected function isCounterCanMarkAsVisited(param1:String, param2:CountersVo) : Boolean
      {
         if(this._limitedUISettingBlock && param2.componentId == GAME_COUNTER_LIMITED_UI_CONTROL)
         {
            return true;
         }
         return super.isCounterCanMarkAsVisited(param1,param2);
      }
      
      public function getContent() : GameSettingsContent
      {
         return GameSettingsContent(this.scrollPane.target);
      }
      
      public function setLimitedUISettingVisible(param1:Boolean) : void
      {
         var _loc2_:Class = null;
         if(!this._limitedUISettingBlock)
         {
            _loc2_ = App.utils.classFactory.getClass(Linkages.LIMITED_UI_SETTING_BLOCK);
            this._limitedUISettingBlock = new _loc2_();
            this._limitedUISettingBlock.x = LIMITED_UI_SETTING_BLOCK_X;
            addChild(this._limitedUISettingBlock);
            this._limitedUISettingBlock.addEventListener(LimitedUIEvent.TURN_OFF,this.onLimitedUITurnOffHandler);
         }
         this._limitedUISettingBlock.visible = param1;
         this.scrollPane.y = !!param1 ? Number(LIMITED_UI_SETTING_BLOCK_PADDING) : Number(0);
         this.scrollPane.setSize(PANE_WIDTH,!!param1 ? Number(PANE_HEIGHT_WITH_LIMITED_UI_SETTING_BLOCK) : Number(PANE_HEIGHT));
         invalidateCounter();
      }
      
      private function setupLabel(param1:LabelControl, param2:String) : void
      {
         param1.text = param2;
      }
      
      private function setupSlider(param1:Slider, param2:Number, param3:Boolean) : void
      {
         param1.value = param2;
         param1.enabled = param3;
         param1.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
      }
      
      private function setupDropDown(param1:DropdownMenu, param2:SettingsControlProp, param3:Boolean) : void
      {
         if(param1.dataProvider != null)
         {
            param1.dataProvider.cleanUp();
         }
         param1.dataProvider = new DataProvider(param2.options);
         param1.menuRowCount = param2.options is Array ? Number(param2.options.length) : Number(0);
         param1.selectedIndex = int(param2.current);
         param1.addEventListener(ListEvent.INDEX_CHANGE,this.onDropdownIndexChangeHandler);
         param1.enabled = param3;
      }
      
      private function setupCheckBox(param1:CheckBox, param2:Boolean, param3:Boolean) : void
      {
         param1.selected = param2;
         param1.enabled = param3;
         param1.addEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
      }
      
      private function setupButtonBar(param1:ButtonBarEx, param2:SettingsControlProp, param3:Boolean) : void
      {
         if(param1.dataProvider != null)
         {
            param1.dataProvider.cleanUp();
         }
         param1.dataProvider = new DataProvider(param2.options);
         param1.enabled = param3;
         param1.selectedIndex = int(param2.current);
         param1.addEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
      }
      
      private function onLimitedUITurnOffHandler(param1:LimitedUIEvent) : void
      {
         var _loc2_:SettingViewEvent = new SettingViewEvent(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,viewId,formId,null,[GAME_COUNTER_LIMITED_UI_CONTROL]);
         dispatchEvent(_loc2_);
      }
      
      private function onSliderValueChangeHandler(param1:SliderEvent) : void
      {
         var _loc2_:Slider = Slider(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_SLIDER);
         var _loc4_:SettingsControlProp = SettingsControlProp(data[_loc3_]);
         var _loc5_:GameSettingsContent = this.getContent();
         var _loc6_:String = _loc3_ + SettingsConfigHelper.TYPE_VALUE;
         if(_loc4_.hasValue && _loc5_[_loc6_])
         {
            this.setupLabel(LabelControl(_loc5_[_loc6_]),_loc2_.value.toString());
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc2_.value));
      }
      
      private function onDropdownIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:DropdownMenu = DropdownMenu(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_DROPDOWN);
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc2_.selectedIndex));
      }
      
      private function onButtonBarIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc5_:String = null;
         var _loc2_:ButtonBarEx = ButtonBarEx(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_BUTTON_BAR);
         var _loc4_:GameSettingsContent = this.getContent();
         if(_loc3_ == SettingsConfigHelper.CAROUSEL_TYPE)
         {
            _loc5_ = SettingsConfigHelper.CAROUSEL_TYPE_ID[_loc2_.selectedIndex];
            _loc4_.doubleCarouselTypeDropDown.enabled = _loc5_ == SettingsConfigHelper.CAROUSEL_DOUBLE;
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc2_.selectedIndex));
      }
      
      private function onCheckBoxSelectHandler(param1:Event) : void
      {
         var _loc2_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(CheckBox(param1.target).name,SettingsConfigHelper.TYPE_CHECKBOX);
         var _loc3_:Boolean = CheckBox(param1.target).selected;
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc2_,_loc3_));
      }
   }
}
