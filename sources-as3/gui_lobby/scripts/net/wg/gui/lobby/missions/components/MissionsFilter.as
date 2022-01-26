package net.wg.gui.lobby.missions.components
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import net.wg.data.constants.generated.QUESTS_ALIASES;
   import net.wg.gui.components.carousels.interfaces.IFilterCounter;
   import net.wg.gui.components.controls.IconTextButton;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.managers.IPopoverManager;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class MissionsFilter extends UIComponentEx implements IPopOverCaller
   {
      
      private static const FILTER_BUTTON_ICON_OFFSET_LEFT:int = 10;
      
      private static const FILTER_BUTTON_ICON_OFFSET_TOP:int = 1;
      
      private static const FILTER_COUNTER_Y_SHIFT:int = -41;
       
      
      public var filterButton:IconTextButton;
      
      public var tasksLabel:TextField;
      
      public var filterCounter:IFilterCounter;
      
      private var _popoverMgr:IPopoverManager = null;
      
      public function MissionsFilter()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._popoverMgr = App.popoverMgr;
         this.filterButton.addEventListener(ButtonEvent.CLICK,this.onFilterButtonClickHandler);
         this.filterButton.tooltip = QUESTS.MISSIONS_FILTER_FILTERBUTTON;
         this.filterButton.iconOffsetLeft = FILTER_BUTTON_ICON_OFFSET_LEFT;
         this.filterButton.iconOffsetTop = FILTER_BUTTON_ICON_OFFSET_TOP;
         this.filterButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_FILTER;
         this.filterCounter.setCloseButtonTooltip(QUESTS.MISSIONS_FILTERCOUNTER_CLOSEBUTTON);
         this.tasksLabel.htmlText = QUESTS.MISSIONS_FILTERCOUNTER_LABEL;
         App.utils.commons.updateTextFieldSize(this.tasksLabel,true,false);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.filterCounter.x = this.tasksLabel.x + this.tasksLabel.width + FILTER_COUNTER_Y_SHIFT;
         }
      }
      
      override protected function onDispose() : void
      {
         this.filterButton.removeEventListener(ButtonEvent.CLICK,this.onFilterButtonClickHandler);
         this.filterButton.dispose();
         this.filterButton = null;
         this.filterCounter.dispose();
         this.filterCounter = null;
         this.tasksLabel = null;
         this._popoverMgr = null;
         super.onDispose();
      }
      
      public function blink() : void
      {
         this.filterCounter.blink();
      }
      
      public function getHitArea() : DisplayObject
      {
         return this.filterButton;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this.filterButton;
      }
      
      public function showFilterCounter(param1:String, param2:Boolean) : void
      {
         this.filterCounter.setCount(param1,false,param2);
      }
      
      private function onFilterButtonClickHandler(param1:ButtonEvent) : void
      {
         this._popoverMgr.show(this,QUESTS_ALIASES.MISSIONS_FILTER_POPOVER_ALIAS);
      }
   }
}
