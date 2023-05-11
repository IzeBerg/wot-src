package net.wg.gui.lobby.tankman
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.CompactCheckBox;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.tankman.crewSkins.CrewSkinNoItemsInfo;
   import net.wg.gui.lobby.tankman.crewSkins.CrewSkinSoundInfo;
   import net.wg.gui.lobby.tankman.crewSkins.CrewSkinStorageInfo;
   import net.wg.gui.lobby.tankman.crewSkins.CrewSkinsMainContainer;
   import net.wg.gui.lobby.tankman.crewSkins.CrewSkinsWarning;
   import net.wg.gui.lobby.tankman.crewSkins.model.CrewSkinVO;
   import net.wg.gui.lobby.tankman.crewSkins.model.PersonalCaseCrewSkinsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ScrollBar;
   import scaleform.clik.events.ButtonEvent;
   
   public class PersonalCaseCrewSkins extends UIComponentEx implements IViewStackContent
   {
      
      private static const UPDATE_LIST_VISIBILITY:String = "updateListVisibility";
       
      
      private const SCROLL_OFFSET:int = 90;
      
      private const DOTS:String = " ...";
      
      public var cbHistoricallyAccurate:CompactCheckBox;
      
      public var skinsScrollPane:ResizableScrollPane;
      
      public var skinsScrollBar:ScrollBar;
      
      public var crewSkinsListBottomDivider:Sprite;
      
      public var tfSkinName:TextField;
      
      public var tfSkinDescr:TextField;
      
      public var noItemsInfo:CrewSkinNoItemsInfo;
      
      public var tfSoundTitle:TextField;
      
      public var soundInfo:CrewSkinSoundInfo;
      
      public var storageInfo:CrewSkinStorageInfo;
      
      public var selectBtn:ISoundButtonEx;
      
      public var unselectBtn:ISoundButtonEx;
      
      public var warning:CrewSkinsWarning;
      
      private var _selectedSkin:CrewSkinVO;
      
      private var _model:PersonalCaseCrewSkinsVO;
      
      public function PersonalCaseCrewSkins()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.cbHistoricallyAccurate.removeEventListener(Event.SELECT,this.changeHistoricallyAccurateHandler);
         this.cbHistoricallyAccurate.dispose();
         this.cbHistoricallyAccurate = null;
         this.skinsScrollPane.removeEventListener(PersonalCaseEvent.INIT_CREW_SKINS_SCROLL,this.initCrewSkinsScrollHandler);
         this.skinsScrollPane.removeEventListener(PersonalCaseEvent.UPDATE_SELECTED_CREW_SKIN_INFO,this.updateSelectedCrewSkinInfoHandler);
         this.skinsScrollPane.dispose();
         this.skinsScrollPane = null;
         this.skinsScrollBar.dispose();
         this.skinsScrollBar = null;
         this.crewSkinsListBottomDivider = null;
         this.tfSkinName = null;
         this.tfSkinDescr = null;
         this.noItemsInfo = null;
         this.tfSoundTitle = null;
         this.soundInfo = null;
         this.storageInfo = null;
         this.selectBtn.removeEventListener(ButtonEvent.CLICK,this.selectSkinHandler);
         this.selectBtn.dispose();
         this.selectBtn = null;
         this.unselectBtn.removeEventListener(ButtonEvent.CLICK,this.unselectSkinHandler);
         this.unselectBtn.dispose();
         this.unselectBtn = null;
         this.warning.removeEventListener(MouseEvent.ROLL_OVER,this.warningOverHandler);
         this.warning.removeEventListener(MouseEvent.ROLL_OUT,this.warningOutHandler);
         this.warning = null;
         this._selectedSkin = null;
         this._model = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.skinsScrollPane.addEventListener(PersonalCaseEvent.INIT_CREW_SKINS_SCROLL,this.initCrewSkinsScrollHandler);
         this.skinsScrollPane.addEventListener(PersonalCaseEvent.UPDATE_SELECTED_CREW_SKIN_INFO,this.updateSelectedCrewSkinInfoHandler);
         this.selectBtn.addEventListener(ButtonEvent.CLICK,this.selectSkinHandler);
         this.unselectBtn.addEventListener(ButtonEvent.CLICK,this.unselectSkinHandler);
         this.warning.addEventListener(MouseEvent.ROLL_OVER,this.warningOverHandler);
         this.warning.addEventListener(MouseEvent.ROLL_OUT,this.warningOutHandler);
         this.soundInfo.addEventListener(MouseEvent.ROLL_OVER,this.soundInfoOverHandler);
         this.soundInfo.addEventListener(MouseEvent.ROLL_OUT,this.soundInfoOutHandler);
         this.cbHistoricallyAccurate.addEventListener(Event.SELECT,this.changeHistoricallyAccurateHandler,false,0,true);
         CrewSkinsMainContainer(this.skinsScrollPane.target).nonHistoricalBlockVisibility = !this.cbHistoricallyAccurate.selected;
         this.tfSoundTitle.text = App.utils.locale.makeString(CREW_SKINS.FEATURE_SOUND_HEADER);
         this.crewSkinsListBottomDivider.mouseEnabled = this.crewSkinsListBottomDivider.mouseChildren = false;
      }
      
      override protected function draw() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         super.draw();
         if(this._model)
         {
            _loc2_ = true;
            _loc3_ = "";
            this.cbHistoricallyAccurate.enabled = true;
            if(!this._model.historicalList.length && !this._model.nonHistoricalList.length)
            {
               _loc2_ = false;
               _loc3_ = CREW_SKINS.FEATURE_NOCONTENT_DESC2;
               this.cbHistoricallyAccurate.enabled = false;
            }
            else if(this.cbHistoricallyAccurate.selected && !this._model.historicalList.length)
            {
               _loc2_ = false;
               _loc3_ = CREW_SKINS.FEATURE_NOCONTENT_DESC1;
            }
            this.skinsScrollPane.visible = this.soundInfo.visible = this.storageInfo.visible = this.selectBtn.visible = this.unselectBtn.visible = this.crewSkinsListBottomDivider.visible = this.tfSkinName.visible = this.tfSkinDescr.visible = this.tfSoundTitle.visible = this.warning.visible = _loc2_;
            this.updateButtonsVisibility();
            this.noItemsInfo.reason = _loc3_;
            this.noItemsInfo.visible = !_loc2_;
         }
         var _loc1_:CrewSkinsMainContainer = CrewSkinsMainContainer(this.skinsScrollPane.target);
         if(this._model && isInvalid(InvalidationType.DATA))
         {
            _loc1_.updateCrewSkinsData(this._model.historicalList,this._model.nonHistoricalList);
         }
         if(isInvalid(UPDATE_LIST_VISIBILITY))
         {
            _loc1_.nonHistoricalBlockVisibility = !this.cbHistoricallyAccurate.selected;
         }
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:PersonalCaseCrewSkinsVO = this._model;
         this._model = param1 as PersonalCaseCrewSkinsVO;
         App.utils.asserter.assertNotNull(this._model,"_skinModel" + Errors.CANT_NULL);
         if(!_loc2_ && this._model)
         {
            this.cbHistoricallyAccurate.selected = this._model.historicallyAccurate;
         }
         invalidateData();
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      private function initCrewSkinsScrollHandler(param1:PersonalCaseEvent) : void
      {
         var _loc4_:Number = NaN;
         var _loc2_:Number = this.skinsScrollPane.getContentHeight();
         var _loc3_:Number = Math.max(0,(_loc2_ - this.skinsScrollPane.availableHeight) / this.skinsScrollPane.scrollStepFactor);
         this.skinsScrollBar.setScrollProperties(_loc2_,0,_loc3_);
         if(param1.selectedCrewSkinPosY > this.SCROLL_OFFSET)
         {
            _loc4_ = (param1.selectedCrewSkinPosY - this.SCROLL_OFFSET) / (_loc2_ - this.skinsScrollPane.availableHeight);
         }
         else
         {
            _loc4_ = 0;
         }
         this.skinsScrollBar.position = _loc4_ * _loc3_;
         this.skinsScrollPane.invalidateSize();
      }
      
      private function updateSelectedCrewSkinInfoHandler(param1:PersonalCaseEvent) : void
      {
         var _loc2_:String = null;
         this._selectedSkin = param1.crewSkinModel;
         if(this._selectedSkin)
         {
            this.tfSkinName.text = this._selectedSkin.fullName;
            _loc2_ = App.utils.locale.makeString(this._selectedSkin.description);
            App.utils.commons.truncateTextFieldMultiline(this.tfSkinDescr,_loc2_,3,this.DOTS);
            this.soundInfo.update(this._selectedSkin.id,this._selectedSkin.soundSetName,this._selectedSkin.soundSetID.length > 1,this._selectedSkin.soundSetIsAvailable);
            this.storageInfo.update(this._selectedSkin.freeCount,this._selectedSkin.maxCount,this._selectedSkin.useCount);
         }
         this.updateButtonsVisibility();
      }
      
      private function updateButtonsVisibility() : void
      {
         var _loc1_:String = null;
         if(!this._selectedSkin)
         {
            this.selectBtn.visible = this.unselectBtn.visible = this.warning.visible = false;
         }
         else if(this._selectedSkin.isAvailable)
         {
            if(this._selectedSkin.freeCount == 0 && !this._selectedSkin.isEquip)
            {
               _loc1_ = CREW_SKINS.FEATURE_TAB_ALLUSED;
               this.warning.toolTip = TOOLTIPS_CONSTANTS.CREW_SKIN_NO_AVAILABLE_SKINS;
            }
            else
            {
               this.unselectBtn.visible = this._selectedSkin.isEquip;
               this.selectBtn.visible = !this.unselectBtn.visible;
            }
         }
         else
         {
            _loc1_ = this._selectedSkin.notAvailableMessage;
            this.warning.toolTip = TOOLTIPS_CONSTANTS.CREW_SKIN_RESTRICTED;
         }
         if(_loc1_)
         {
            this.selectBtn.visible = this.unselectBtn.visible = false;
            this.warning.update(_loc1_);
            this.warning.x = Math.round(this.selectBtn.x + (this.selectBtn.width - this.warning.width) / 2);
         }
         this.warning.visible = Boolean(_loc1_);
      }
      
      private function selectSkinHandler(param1:ButtonEvent) : void
      {
         var _loc2_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.EQUIP_CREW_SKIN,true);
         _loc2_.crewSkinID = this._selectedSkin.id;
         dispatchEvent(_loc2_);
      }
      
      private function unselectSkinHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new PersonalCaseEvent(PersonalCaseEvent.UNEQUIP_CREW_SKIN,true));
      }
      
      private function changeHistoricallyAccurateHandler(param1:Event) : void
      {
         invalidate(UPDATE_LIST_VISIBILITY);
         var _loc2_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.CHANGE_CREW_SKIN_HISTORICALLY_ACCURATE,true);
         _loc2_.historicallyAccurate = this.cbHistoricallyAccurate.selected;
         dispatchEvent(_loc2_);
      }
      
      private function warningOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showSpecial(this.warning.toolTip,null,this._model.tankmanID,this._selectedSkin.id);
      }
      
      private function warningOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function soundInfoOverHandler(param1:MouseEvent) : void
      {
         if(this._selectedSkin.soundSetID.length > 1)
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CREW_SKIN_SOUND,null,this._model.tankmanID,this._selectedSkin.id);
         }
      }
      
      private function soundInfoOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
