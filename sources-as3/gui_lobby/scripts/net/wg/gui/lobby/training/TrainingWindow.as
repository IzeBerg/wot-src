package net.wg.gui.lobby.training
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.Aliases;
   import net.wg.data.VO.TrainingWindowVO;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.NumericStepper;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.minimap.MinimapPresentation;
   import net.wg.infrastructure.base.meta.ITrainingWindowMeta;
   import net.wg.infrastructure.base.meta.impl.TrainingWindowMeta;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.WrappingMode;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   
   public class TrainingWindow extends TrainingWindowMeta implements ITrainingWindowMeta
   {
      
      private static const ACTIVE_MAP_ALPHA_VALUE:int = 1;
      
      private static const INACTIVE_MAP_ALPHA_VALUE:Number = 0.6;
      
      private static const SLASH:String = "/";
      
      private static const LAYOUT_WITH_LONG_DESC:uint = 0;
      
      private static const LAYOUT_WITH_AVERAGE_DESC:uint = 1;
      
      private static const LAYOUT_WITH_SHORT_DESC:uint = 2;
      
      private static const MAX_PLAYER_TITLE_TF_Y:uint = 65;
      
      private static const MAX_PLAYERS_Y:uint = 85;
      
      private static const BATTLE_TIMER_TITLE_TF_Y:uint = 121;
      
      private static const BATTLE_TIME_Y:uint = 141;
      
      private static const TIMER_INFO_ICON_Y:uint = 151;
      
      private static const IS_PRIVATE_CHECKBOX_Y:uint = 185;
      
      private static const DESCR_TITLE_Y:uint = 213;
      
      private static const DESCRIPTION_Y:uint = 238;
      
      private static const DESCRIPTION_HEIGHT:uint = 132;
      
      private static const LAYOUT_WITH_AVERAGE_DESC_OFFSET_Y:uint = 16;
      
      private static const LAYOUT_WITH_SHORT_DESC_OFFSET_Y:uint = 37;
       
      
      public var mapSelectorTitleTF:TextField = null;
      
      public var maxPlayerTitleTF:TextField = null;
      
      public var battleTimerTitleTF:TextField = null;
      
      public var descrTitleTF:TextField = null;
      
      public var mapName:TextField;
      
      public var battleType:TextField;
      
      public var maxPlayers:TextField;
      
      public var maps:ScrollingListEx;
      
      public var battleTime:NumericStepper;
      
      public var timerInfoIcon:InfoIcon;
      
      public var isPrivate:CheckBox;
      
      public var description:TextAreaSimple;
      
      public var createButon:SoundButtonEx;
      
      public var closeButon:SoundButtonEx;
      
      public var minimap:MinimapPresentation;
      
      public var additionalInfo:AdditionalInfo = null;
      
      private var _mapsData:DataProvider;
      
      private var _paramsVO:TrainingWindowVO;
      
      private var _dataWasSetted:Boolean = false;
      
      private var _layoutType:uint = 0;
      
      public function TrainingWindow()
      {
         super();
      }
      
      private static function onPrivateCheckboxRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.TRAINING_CREATE_INVITES_CHECKBOX);
      }
      
      private static function onPrivateCheckboxRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mapSelectorTitleTF.text = MENU.TRAINING_CREATE_MAPSELECT;
         this.maxPlayerTitleTF.text = MENU.TRAINING_CREATE_MAXPLAYERS;
         this.battleTimerTitleTF.text = MENU.TRAINING_CREATE_BATTLETIME;
         this.descrTitleTF.text = MENU.TRAINING_CREATE_DESCRIPTION;
         this.createButon.addEventListener(ButtonEvent.CLICK,this.onCreateButtonClickHandler);
         this.closeButon.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.isPrivate.addEventListener(MouseEvent.ROLL_OVER,onPrivateCheckboxRollOverHandler);
         this.isPrivate.addEventListener(MouseEvent.ROLL_OUT,onPrivateCheckboxRollOutHandler);
         this.isPrivate.addEventListener(MouseEvent.CLICK,onPrivateCheckboxRollOutHandler);
         this.maps.addEventListener(ListEvent.INDEX_CHANGE,this.onMapIndexChangeHandler);
         this.maps.wrapping = WrappingMode.STICK;
         this.description.text = Values.EMPTY_STR;
         this.timerInfoIcon.tooltip = MENU.TRAINING_CREATE_BATTLETIME_DISABLED;
         this.timerInfoIcon.visible = false;
         this.additionalInfo.visible = false;
         this.additionalInfo.setContentLayout(AdditionalInfoContent.LAYOUT_SMALL_WITH_TEXT_AND_SEPARATOR);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.createButon);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = true;
         registerFlashComponentS(this.minimap,Aliases.LOBBY_MINIMAP);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.createButon.removeEventListener(ButtonEvent.CLICK,this.onCreateButtonClickHandler);
         this.closeButon.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.isPrivate.removeEventListener(MouseEvent.ROLL_OVER,onPrivateCheckboxRollOverHandler);
         this.isPrivate.removeEventListener(MouseEvent.ROLL_OUT,onPrivateCheckboxRollOutHandler);
         this.isPrivate.removeEventListener(MouseEvent.CLICK,onPrivateCheckboxRollOutHandler);
         this.maps.removeEventListener(ListEvent.INDEX_CHANGE,this.onMapIndexChangeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.mapSelectorTitleTF = null;
         this.maxPlayerTitleTF = null;
         this.battleTimerTitleTF = null;
         this.descrTitleTF = null;
         this.mapName = null;
         this.battleType = null;
         this.maxPlayers = null;
         this.timerInfoIcon.dispose();
         this.timerInfoIcon = null;
         this.maps.dispose();
         this.maps = null;
         this.battleTime.dispose();
         this.battleTime = null;
         this.isPrivate.dispose();
         this.isPrivate = null;
         this.description.dispose();
         this.description = null;
         this.createButon.dispose();
         this.createButon = null;
         this.closeButon.dispose();
         this.closeButon = null;
         this.additionalInfo.dispose();
         this.additionalInfo = null;
         this._mapsData = null;
         this._paramsVO = null;
         this.minimap = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         super.draw();
         if(this._paramsVO != null && this._mapsData != null && isInvalid(InvalidationType.DATA))
         {
            this.isPrivate.selected = this._paramsVO.privacy;
            this.isPrivate.enabled = this._paramsVO.canMakeOpenedClosed;
            this.descrTitleTF.visible = this.description.visible = this._paramsVO.isShowComment;
            if(this._paramsVO.isShowComment)
            {
               this.description.text = this._paramsVO.description;
               this.description.validateNow();
               this.description.enabled = this._paramsVO.canChangeComment;
            }
            this.battleTime.maximum = this._paramsVO.maxBattleTime;
            this.maps.mouseEnabled = this.maps.mouseChildren = this._paramsVO.canChangeArena;
            this.maps.alpha = !!this._paramsVO.canChangeArena ? Number(ACTIVE_MAP_ALPHA_VALUE) : Number(INACTIVE_MAP_ALPHA_VALUE);
            this.maps.dataProvider = this._mapsData;
            window.title = this._paramsVO.wndTitle;
            if(this._paramsVO.create)
            {
               this.maps.selectedIndex = Math.floor(Math.random() * this._mapsData.length);
               this.isPrivate.selected = false;
            }
            else
            {
               this.createButon.label = MENU.TRAINING_INFO_SETTINGS_OKBUTTON;
               _loc1_ = this._mapsData.length;
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  if(this._paramsVO.arena == this._mapsData[_loc2_].key)
                  {
                     this.maps.selectedIndex = _loc2_;
                     this._dataWasSetted = true;
                     break;
                  }
                  _loc2_++;
               }
            }
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            _loc3_ = 0;
            if(this._layoutType == LAYOUT_WITH_AVERAGE_DESC)
            {
               _loc3_ = LAYOUT_WITH_AVERAGE_DESC_OFFSET_Y;
            }
            else if(this._layoutType == LAYOUT_WITH_SHORT_DESC)
            {
               _loc3_ = LAYOUT_WITH_SHORT_DESC_OFFSET_Y;
            }
            this.maxPlayerTitleTF.y = MAX_PLAYER_TITLE_TF_Y + _loc3_;
            this.maxPlayers.y = MAX_PLAYERS_Y + _loc3_;
            this.battleTimerTitleTF.y = BATTLE_TIMER_TITLE_TF_Y + _loc3_;
            this.battleTime.y = BATTLE_TIME_Y + _loc3_;
            this.timerInfoIcon.y = TIMER_INFO_ICON_Y + _loc3_;
            this.isPrivate.y = IS_PRIVATE_CHECKBOX_Y + _loc3_;
            this.descrTitleTF.y = DESCR_TITLE_Y + _loc3_;
            this.description.y = DESCRIPTION_Y + _loc3_;
            this.description.height = DESCRIPTION_HEIGHT - _loc3_;
         }
      }
      
      override protected function setData(param1:TrainingWindowVO, param2:DataProvider) : void
      {
         this._paramsVO = param1;
         this._mapsData = param2;
         invalidateData();
      }
      
      private function onCloseButtonClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      private function onCreateButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:Number = this._mapsData[this.maps.selectedIndex].key;
         var _loc3_:Number = this.battleTime.value;
         var _loc4_:int = !!this.isPrivate.selected ? int(1) : int(Values.ZERO);
         var _loc5_:String = Boolean(this.description.text) ? this.description.text : Values.EMPTY_STR;
         updateTrainingRoomS(_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      private function onMapIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:Object = null;
         if(param1.index > Values.DEFAULT_INT && param1.index < this._mapsData.length)
         {
            _loc2_ = param1.itemData;
            this.mapName.text = _loc2_.name;
            this.battleType.text = _loc2_.arenaType;
            this.additionalInfo.visible = _loc2_.additionalInfo;
            this.additionalInfo.setType(_loc2_.additionalInfo);
            this.maxPlayers.text = _loc2_.size + SLASH + _loc2_.size;
            this.battleTime.value = _loc2_.time;
            this.battleTime.enabled = _loc2_.canChangeArenaTime;
            this.timerInfoIcon.visible = !_loc2_.canChangeArenaTime;
            this.minimap.setMapS(_loc2_.key);
            if(StringUtils.isEmpty(this.battleType.text))
            {
               this._layoutType = LAYOUT_WITH_LONG_DESC;
            }
            else if(_loc2_.additionalInfo)
            {
               this._layoutType = LAYOUT_WITH_SHORT_DESC;
            }
            else
            {
               this._layoutType = LAYOUT_WITH_AVERAGE_DESC;
            }
            invalidateLayout();
         }
         if(this._dataWasSetted && this._paramsVO)
         {
            this.battleTime.value = this._paramsVO.timeout;
            this._dataWasSetted = false;
         }
      }
   }
}
