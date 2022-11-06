package net.wg.gui.lobby.hangar
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.hangar.data.SwitchModePanelVO;
   import net.wg.infrastructure.base.meta.ISwitchModePanelMeta;
   import net.wg.infrastructure.base.meta.impl.SwitchModePanelMeta;
   import scaleform.clik.events.ButtonEvent;
   
   public class SwitchModePanel extends SwitchModePanelMeta implements ISwitchModePanelMeta
   {
      
      private static const CHECK_BOX_RIGHT_PADDING:int = 15;
       
      
      public var imgIcon:Image = null;
      
      public var button:ISoundButtonEx = null;
      
      public var label:TextField = null;
      
      public var checkBoxAutoSquad:CheckBox = null;
      
      public var autoSquadInfo:InfoIcon = null;
      
      public function SwitchModePanel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.button.addEventListener(ButtonEvent.CLICK,this.onButtonClick);
         this.checkBoxAutoSquad.addEventListener(Event.SELECT,this.onSelectCheckBoxAutoSquadHandler);
      }
      
      override protected function onDispose() : void
      {
         this.imgIcon.dispose();
         this.imgIcon = null;
         this.button.removeEventListener(ButtonEvent.CLICK,this.onButtonClick);
         this.button.dispose();
         this.button = null;
         this.label = null;
         this.checkBoxAutoSquad.removeEventListener(Event.SELECT,this.onSelectCheckBoxAutoSquadHandler);
         this.checkBoxAutoSquad.dispose();
         this.checkBoxAutoSquad = null;
         this.autoSquadInfo.dispose();
         this.autoSquadInfo = null;
         super.onDispose();
      }
      
      override protected function setData(param1:SwitchModePanelVO) : void
      {
         this.imgIcon.source = param1.iconSource;
         this.button.label = param1.buttonLabel;
         this.label.htmlText = param1.label;
         this.label.autoSize = TextFieldAutoSize.LEFT;
         this.label.y = height - this.label.height >> 1;
         this.checkBoxAutoSquad.label = param1.autoSquadLabel;
         this.checkBoxAutoSquad.selected = param1.autoSquadEnabled;
         this.checkBoxAutoSquad.autoSize = TextFieldAutoSize.LEFT;
         this.autoSquadInfo.tooltip = param1.autoSquadInfoTooltip;
         this.checkBoxAutoSquad.visible = param1.autoSquadIsVisible;
         this.autoSquadInfo.visible = param1.autoSquadIsVisible;
         this.updateAutoSquadElementsPosition();
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         if(param1 != visible)
         {
            visible = param1;
         }
      }
      
      private function updateAutoSquadElementsPosition() : void
      {
         this.checkBoxAutoSquad.validateNow();
         var _loc1_:int = this.checkBoxAutoSquad.textField.width;
         this.autoSquadInfo.x = this.checkBoxAutoSquad.x + _loc1_ + CHECK_BOX_RIGHT_PADDING;
      }
      
      private function onSelectCheckBoxAutoSquadHandler(param1:Event) : void
      {
         onSelectCheckBoxAutoSquadS(this.checkBoxAutoSquad.selected);
      }
      
      private function onButtonClick(param1:ButtonEvent) : void
      {
         switchModeS();
      }
   }
}
