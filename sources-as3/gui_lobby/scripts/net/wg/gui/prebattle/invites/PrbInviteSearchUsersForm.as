package net.wg.gui.prebattle.invites
{
   import flash.display.InteractiveObject;
   import flash.ui.Keyboard;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TextInput;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   
   public class PrbInviteSearchUsersForm extends InviteStackContainerBase
   {
       
      
      public var nameInput:TextInput;
      
      public var searchButton:SoundButtonEx;
      
      private var searchButtonIntervalID:uint = 0;
      
      public function PrbInviteSearchUsersForm()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         this.nameInput.focusable = true;
         if(this.searchButton != null)
         {
            this.searchButton.addEventListener(ButtonEvent.CLICK,this.handleSearchUsers);
            this.nameInput.addEventListener(InputEvent.INPUT,this.handleInput);
         }
         if(rosterList != null)
         {
            rosterList.labelField = "displayName";
         }
         super.configUI();
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.details.code == Keyboard.ENTER && param1.details.value == InputValue.KEY_UP)
         {
            if((this.nameInput.focused || this.searchButton.focused) && this.searchButton.enabled)
            {
               this.handleSearchUsers();
               param1.handled = true;
            }
         }
      }
      
      private function handleSearchUsers(param1:ButtonEvent = null) : void
      {
         var _loc2_:String = StringUtils.trim(this.nameInput.text);
         if(_loc2_ == null)
         {
            return;
         }
         rosterList.selectedIndex = -1;
         this.coolDownButton();
         var _loc3_:SendInvitesEvent = new SendInvitesEvent(SendInvitesEvent.SEARCH_TOKEN,true);
         _loc3_.searchString = _loc2_;
         dispatchEvent(_loc3_);
      }
      
      private function coolDownButton() : void
      {
         this.enableButton(false);
         this.searchButtonIntervalID = setTimeout(this.enableButton,1000,true);
      }
      
      private function enableButton(param1:Boolean = false) : void
      {
         this.searchButton.enabled = param1;
         if(this.searchButtonIntervalID != 0)
         {
            clearTimeout(this.searchButtonIntervalID);
         }
      }
      
      override public function getComponentForFocus() : InteractiveObject
      {
         return this.nameInput;
      }
      
      override protected function onDispose() : void
      {
         if(this.searchButton != null)
         {
            this.searchButton.removeEventListener(ButtonEvent.CLICK,this.handleSearchUsers);
            this.nameInput.removeEventListener(InputEvent.INPUT,this.handleInput);
         }
         super.onDispose();
      }
   }
}
