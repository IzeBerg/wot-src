package net.wg.gui.lobby.header.itemSelectorPopover
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.header.events.BattleTypeSelectorEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.events.ButtonEvent;
   
   public class BattleTypeSelectPopoverDemonstrator extends UIComponentEx
   {
       
      
      public var label:TextField = null;
      
      public var button:SoundButtonEx = null;
      
      public function BattleTypeSelectPopoverDemonstrator()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.label.text = MENU.HEADER_DEMONSTRATION_INFO;
         this.button.label = MENU.HEADER_DEMONSTRATION_BTNLABEL;
         this.button.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.label = null;
         this.button.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.button.dispose();
         this.button = null;
         super.onDispose();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         this.button.enabled = param1;
         super.enabled = param1;
      }
      
      private function onButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new BattleTypeSelectorEvent(BattleTypeSelectorEvent.BATTLE_TYPE_ITEM_EVENT,BattleTypeSelectorEvent.ITEM_ID_DEMO_CLICK));
      }
   }
}
