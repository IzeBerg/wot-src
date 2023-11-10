package net.wg.gui.lobby.training
{
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class ObserverButtonComponent extends UIComponentEx
   {
      
      public static const SELECTED:String = "selChanged";
       
      
      public var icon:UILoaderAlt;
      
      public var button:BlackButton;
      
      private var _selected:Boolean;
      
      private var _defColorTrans:ColorTransform;
      
      private var _tooltipViewer:TooltipViewer;
      
      public function ObserverButtonComponent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._defColorTrans = this.icon.transform.colorTransform;
         this.icon.source = RES_ICONS.MAPS_ICONS_LIBRARY_USSR_OBSERVER;
         this.button.toggleEnable = true;
         this.button.mouseEnabledOnDisabled = true;
         this.button.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler,false,0,true);
         this.button.label = App.utils.locale.makeString(MENU.TRAINING_INFO_OBSERVER);
         if(this._tooltipViewer == null)
         {
            this._tooltipViewer = new TooltipViewer(this.icon);
         }
         this.updateTooltip();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateData();
         }
      }
      
      private function updateData() : void
      {
         this.button.selected = this._selected;
         if(this._selected)
         {
            this.icon.transform.colorTransform = App.colorSchemeMgr.getTransform(TrainingConstants.VEHICLE_YELLOW_COLOR_SCHEME_ALIAS);
         }
         else
         {
            this.icon.transform.colorTransform = this._defColorTrans;
         }
         this.updateTooltip();
      }
      
      private function updateTooltip() : void
      {
         if(enabled)
         {
            this._tooltipViewer.setTooltip(!!this._selected ? TOOLTIPS.TRAINING_OBSERVER_SELECTEDICON : TOOLTIPS.TRAINING_OBSERVER_ICON);
            this.button.tooltip = TOOLTIPS.TRAINING_OBSERVER_BTN;
         }
         else
         {
            this._tooltipViewer.setTooltip(null);
            this.button.tooltip = null;
         }
      }
      
      private function onButtonClickHandler(param1:ButtonEvent) : void
      {
         this.button.selected = !this.button.selected;
         this._selected = this.button.selected;
         this.updateData();
         dispatchEvent(new Event(SELECTED));
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(this._selected != param1)
         {
            this._selected = param1;
            invalidateData();
         }
      }
      
      override protected function onDispose() : void
      {
         this.button.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this._tooltipViewer.dispose();
         this._tooltipViewer = null;
         this.icon.dispose();
         this.icon = null;
         this.button.dispose();
         this.button = null;
         this._defColorTrans = null;
         super.onDispose();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.icon.alpha = !!param1 ? Number(1) : Number(0.5);
         this.button.enabled = param1;
         this.updateTooltip();
      }
   }
}
