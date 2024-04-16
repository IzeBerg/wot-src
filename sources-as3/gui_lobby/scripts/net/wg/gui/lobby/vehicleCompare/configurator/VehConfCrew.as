package net.wg.gui.lobby.vehicleCompare.configurator
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.lobby.vehicleCompare.data.VehCompareCrewLevelVO;
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
      
      private static const SCROLL_WIDTH:int = 622;
      
      private static const SCROLL_HEIGHT:int = 190;
      
      private static const SCROLL_BAR_HEIGHT:int = 188;
       
      
      public var titleTf:TextField;
      
      public var infoIcon:IInfoIcon;
      
      public var attentionIcon:Image;
      
      public var crewDropDown:DropdownMenu;
      
      public var skillsScrollPane:ResizableScrollPane;
      
      public var tileGroup:GroupEx = null;
      
      public var scrollBar:ScrollBar = null;
      
      public var titleHit:DisplayObject;
      
      public var fade:SkillsFade;
      
      private var _data:VehicleCompareConfiguratorVO;
      
      private var _crewDP:DataProvider;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _crewLevelIndex:int;
      
      public function VehConfCrew()
      {
         super();
         this._tooltipMgr = App.toolTipMgr;
         this._crewDP = new DataProvider();
      }
      
      override protected function onDispose() : void
      {
         this._tooltipMgr = null;
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
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.skillsScrollPane.target = null;
         this.skillsScrollPane.dispose();
         this.skillsScrollPane = null;
         if(this.tileGroup)
         {
            this.tileGroup.dispose();
            this.tileGroup = null;
         }
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
         this.tileGroup.layout = new ConfSkillsLayout();
         this.tileGroup.itemRendererLinkage = Linkages.VEH_CONF_CREW_SKILL_SLOT_UI;
         this.skillsScrollPane.target = this.tileGroup;
         this.skillsScrollPane.setSize(SCROLL_WIDTH,SCROLL_HEIGHT);
         this.scrollBar.height = SCROLL_BAR_HEIGHT;
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
         return this.tileGroup.renderers as Vector.<InteractiveObject>;
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
      
      public function setSkills(param1:DataProvider) : void
      {
         this.tileGroup.dataProvider = param1;
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
         this._tooltipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.VEH_CMP_SKILLS);
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
