package net.wg.gui.lobby.vehicleCompare.configurator
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import net.wg.infrastructure.interfaces.IInfoIcon;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.data.DataProvider;
   
   public class VehConfCrew extends UIComponentEx implements IFocusChainContainer
   {
      
      private static const INFO_ICON_GAP:int = 4;
      
      private static const SCROLL_WIDTH:int = 622;
      
      private static const SCROLL_HEIGHT:int = 190;
      
      private static const SCROLL_BAR_HEIGHT:int = 188;
       
      
      public var titleTf:TextField;
      
      public var infoIcon:IInfoIcon;
      
      public var skillsScrollPane:ResizableScrollPane;
      
      public var tileGroup:GroupEx = null;
      
      public var scrollBar:ScrollBar = null;
      
      public var titleHit:DisplayObject;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function VehConfCrew()
      {
         super();
         this._tooltipMgr = App.toolTipMgr;
      }
      
      override protected function onDispose() : void
      {
         this._tooltipMgr = null;
         this.infoIcon.dispose();
         this.infoIcon = null;
         this.titleTf.removeEventListener(MouseEvent.ROLL_OVER,this.onTitleHitRollOverHandler);
         this.titleTf.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.titleTf = null;
         this.titleHit = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.skillsScrollPane.dispose();
         this.skillsScrollPane = null;
         this.tileGroup = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleTf.text = VEH_COMPARE.VEHCONF_CREWTITLE;
         App.utils.commons.updateTextFieldSize(this.titleTf,true);
         this.infoIcon.x = this.titleTf.x + this.titleTf.width + INFO_ICON_GAP;
         this.titleHit.width = this.infoIcon.x + this.infoIcon.width;
         this.tileGroup.layout = new ConfSkillsLayout();
         this.tileGroup.itemRendererLinkage = Linkages.VEH_CONF_CREW_SKILL_SLOT_UI;
         this.skillsScrollPane.target = this.tileGroup;
         this.skillsScrollPane.setSize(SCROLL_WIDTH,SCROLL_HEIGHT);
         this.scrollBar.height = SCROLL_BAR_HEIGHT;
         this.titleHit.addEventListener(MouseEvent.ROLL_OVER,this.onTitleHitRollOverHandler);
         this.titleHit.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         return this.tileGroup.renderers as Vector.<InteractiveObject>;
      }
      
      public function setSkills(param1:DataProvider) : void
      {
         this.tileGroup.dataProvider = param1;
      }
      
      private function onTitleHitRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.VEH_CMP_SKILLS);
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
