package net.wg.gui.lobby.vehicleCompare.configurator
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.vehicleCompare.data.VehCompareCrewLevelVO;
   import net.wg.gui.lobby.vehicleCompare.data.VehConfSkillVO;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareConfiguratorVO;
   import net.wg.gui.lobby.vehicleCompare.events.VehConfSkillDropDownEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import net.wg.infrastructure.interfaces.IInfoIcon;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   
   public class VehConfCrew extends UIComponentEx implements IFocusChainContainer
   {
      
      private static const INFO_ICON_GAP:int = 4;
      
      private static const ATTENTION_ICON_GAP:int = 20;
       
      
      public var titleTf:TextField;
      
      public var infoIcon:IInfoIcon;
      
      public var attentionIcon:Image;
      
      public var crewDropDown:DropdownMenu;
      
      public var skill0:VehConfCrewSkillSlot;
      
      public var skill1:VehConfCrewSkillSlot;
      
      public var skill2:VehConfCrewSkillSlot;
      
      public var skill3:VehConfCrewSkillSlot;
      
      public var skill4:VehConfCrewSkillSlot;
      
      public var skill5:VehConfCrewSkillSlot;
      
      public var skill6:VehConfCrewSkillSlot;
      
      public var skill7:VehConfCrewSkillSlot;
      
      public var titleHit:DisplayObject;
      
      public var fade:SkillsFade;
      
      private var _skills:Vector.<VehConfCrewSkillSlot>;
      
      private var _data:VehicleCompareConfiguratorVO;
      
      private var _crewDP:DataProvider;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _crewLevelIndex:int;
      
      public function VehConfCrew()
      {
         var _loc2_:VehConfCrewSkillSlot = null;
         super();
         this._tooltipMgr = App.toolTipMgr;
         this._crewDP = new DataProvider();
         this._skills = new <VehConfCrewSkillSlot>[this.skill0,this.skill1,this.skill2,this.skill3,this.skill4,this.skill5,this.skill6,this.skill7];
         var _loc1_:int = 0;
         for each(_loc2_ in this._skills)
         {
            _loc2_.slotIndex = _loc1_++;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:VehConfCrewSkillSlot = null;
         this._tooltipMgr = null;
         for each(_loc1_ in this._skills)
         {
            _loc1_.dispose();
         }
         this._skills.splice(0,this._skills.length);
         this._skills = null;
         this.skill0 = null;
         this.skill1 = null;
         this.skill2 = null;
         this.skill3 = null;
         this.skill4 = null;
         this.skill5 = null;
         this.skill6 = null;
         this.skill7 = null;
         this.crewDropDown.removeEventListener(MouseEvent.ROLL_OVER,this.onCrewDropdownRollOverHandler);
         this.crewDropDown.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.crewDropDown.dispose();
         this.crewDropDown = null;
         this._crewDP.cleanUp();
         this._crewDP = null;
         this.infoIcon.dispose();
         this.infoIcon = null;
         this.fade.dispose();
         this.fade = null;
         this.attentionIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onAttentionIconRollOverHandler);
         this.attentionIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.attentionIcon.dispose();
         this.attentionIcon = null;
         this.titleTf.removeEventListener(MouseEvent.ROLL_OVER,this.onTitleHitRollOverHandler);
         this.titleTf.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.titleTf = null;
         this.titleHit = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleTf.text = VEH_COMPARE.VEHCONF_CREWTITLE;
         App.utils.commons.updateTextFieldSize(this.titleTf,true);
         this.infoIcon.x = this.titleTf.x + this.titleTf.width + INFO_ICON_GAP;
         this.titleHit.width = this.infoIcon.x + this.infoIcon.width;
         this.crewDropDown.dataProvider = this._crewDP;
         this.crewDropDown.addEventListener(MouseEvent.ROLL_OVER,this.onCrewDropdownRollOverHandler);
         this.crewDropDown.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.crewDropDown.enabled = true;
         this.attentionIcon.x = this.crewDropDown.x - ATTENTION_ICON_GAP;
         this.titleHit.addEventListener(MouseEvent.ROLL_OVER,this.onTitleHitRollOverHandler);
         this.titleHit.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this._crewDP.cleanUp();
            this._crewDP.setSource(App.utils.data.vectorToArray(this._data.crewLevels));
            this.crewDropDown.menuRowCount = this._crewDP.length;
            if(this.crewDropDown.selectedIndex != this._crewLevelIndex)
            {
               this.crewDropDown.removeEventListener(ListEvent.INDEX_CHANGE,this.onCrewDropdownIndexChangeHandler);
               this.crewDropDown.selectedIndex = this._crewLevelIndex;
               this.crewDropDown.addEventListener(ListEvent.INDEX_CHANGE,this.onCrewDropdownIndexChangeHandler);
            }
         }
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         return new <InteractiveObject>[this.skill0,this.skill1,this.skill2,this.skill3,this.skill4,this.skill5,this.skill6,this.skill7];
      }
      
      public function setCrewAttentionIconVisible(param1:Boolean) : void
      {
         this.attentionIcon.visible = param1;
         if(param1 && StringUtils.isEmpty(this.attentionIcon.source))
         {
            this.attentionIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ATTENTIONICONFILLED;
            this.attentionIcon.addEventListener(MouseEvent.ROLL_OVER,this.onAttentionIconRollOverHandler);
            this.attentionIcon.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         }
      }
      
      public function setSkills(param1:Vector.<VehConfSkillVO>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._skills)
         {
            _loc2_ = param1.length;
            App.utils.asserter.assert(this._skills.length >= _loc2_,"Skills data contains too much skills. Needed count is " + this._skills.length);
            _loc3_ = 0;
            while(_loc3_ != _loc2_)
            {
               this._skills[_loc3_].setData(param1[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      public function setSkillsFadeVisible(param1:Boolean) : void
      {
         this.fade.visible = param1;
      }
      
      public function setStaticData(param1:VehicleCompareConfiguratorVO) : void
      {
         if(param1 != null)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      public function set crewLevelIndex(param1:int) : void
      {
         this._crewLevelIndex = param1;
         invalidateData();
      }
      
      private function onAttentionIconRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showComplex(VEH_COMPARE.VEHCONF_TOOLTIPS_ATTENTIONICONCREW);
      }
      
      private function onTitleHitRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.VEH_CMP_SKILLS,null);
      }
      
      private function onCrewDropdownRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showComplex(VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_CREWDROPDOWN);
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onCrewDropdownIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:VehConfSkillDropDownEvent = new VehConfSkillDropDownEvent(VehConfSkillDropDownEvent.CREW_LEVEL_CHANGED,VehCompareCrewLevelVO(param1.itemData).id,true);
         dispatchEvent(_loc2_);
      }
   }
}
