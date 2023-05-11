package net.wg.gui.messenger.forms
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.ui.Keyboard;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.messenger.evnts.ChannelsFormEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.Constraints;
   
   public class ChannelsCreateForm extends UIComponentEx implements IViewStackContent
   {
      
      private static const UPDATE_PASSWORD_TEXT:String = "updatePasswordField";
       
      
      public var channelNameLabel:LabelControl = null;
      
      public var channelAutomaticNameLabel:LabelControl = null;
      
      public var channelPasswordLabel:LabelControl = null;
      
      public var channelFillPasswordLabel:LabelControl = null;
      
      public var channelRetypePasswordLabel:LabelControl = null;
      
      public var channelNameInput:TextInput = null;
      
      public var channelPasswordInput:TextInput = null;
      
      public var channelRetypePasswordInput:TextInput = null;
      
      public var channelPasswordCheckBox:CheckBox = null;
      
      public var channelCreateButton:SoundButtonEx = null;
      
      public var bg:Sprite = null;
      
      private var _data:Object = null;
      
      public function ChannelsCreateForm()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "[WG ChannelsCreateForm " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.channelPasswordCheckBox.addEventListener(Event.SELECT,this.onChannelPasswordCheckBoxSelectHandler);
         this.channelCreateButton.addEventListener(ButtonEvent.CLICK,this.onChannelCreateButtonClickHandler);
         this.updateCheckBoxSelected();
         this.channelAutomaticNameLabel.visible = false;
         this.channelNameInput.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         this.channelPasswordInput.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         this.channelRetypePasswordInput.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement("channelNameLabel",this.channelNameLabel,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("channelNameInput",this.channelNameInput,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("channelAutomaticNameLabel",this.channelAutomaticNameLabel,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("channelPasswordLabel",this.channelPasswordLabel,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("channelPasswordCheckBox",this.channelPasswordCheckBox,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("channelFillPasswordLabel",this.channelFillPasswordLabel,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("channelPasswordInput",this.channelPasswordInput,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("channelRetypePasswordLabel",this.channelRetypePasswordLabel,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("channelRetypePasswordInput",this.channelRetypePasswordInput,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("channelCreateButton",this.channelCreateButton,Constraints.LEFT | Constraints.BOTTOM);
         constraints.addElement("bg",this.bg,Constraints.ALL);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(constraints && isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
         }
         if(this.channelPasswordInput && isInvalid(UPDATE_PASSWORD_TEXT))
         {
            this.channelPasswordInput.displayAsPassword = this.channelRetypePasswordInput.displayAsPassword = true;
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.channelPasswordCheckBox.removeEventListener(Event.SELECT,this.onChannelPasswordCheckBoxSelectHandler);
         this.channelCreateButton.removeEventListener(ButtonEvent.CLICK,this.onChannelCreateButtonClickHandler);
         this.channelNameInput.removeEventListener(InputEvent.INPUT,this.handleInput,false);
         this.channelPasswordInput.removeEventListener(InputEvent.INPUT,this.handleInput,false);
         this.channelRetypePasswordInput.removeEventListener(InputEvent.INPUT,this.handleInput,false);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.channelNameLabel.dispose();
         this.channelNameLabel = null;
         this.channelAutomaticNameLabel.dispose();
         this.channelAutomaticNameLabel = null;
         this.channelPasswordLabel.dispose();
         this.channelPasswordLabel = null;
         this.channelFillPasswordLabel.dispose();
         this.channelFillPasswordLabel = null;
         this.channelRetypePasswordLabel.dispose();
         this.channelRetypePasswordLabel = null;
         this.channelNameInput.dispose();
         this.channelNameInput = null;
         this.channelPasswordInput.dispose();
         this.channelPasswordInput = null;
         this.channelRetypePasswordInput.dispose();
         this.channelRetypePasswordInput = null;
         this.channelPasswordCheckBox.dispose();
         this.channelPasswordCheckBox = null;
         this.channelCreateButton.dispose();
         this.channelCreateButton = null;
         this.bg = null;
         this._data = null;
         super.onDispose();
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this.channelNameInput;
      }
      
      public function hideChannelNameInput(param1:Boolean) : void
      {
         this.channelNameInput.visible = !param1;
         this.channelAutomaticNameLabel.visible = param1;
      }
      
      public function update(param1:Object) : void
      {
         this._data = param1;
         invalidate(InvalidationType.DATA);
      }
      
      private function handlePress(param1:uint) : void
      {
         this.createChannel();
      }
      
      private function updateCheckBoxSelected() : void
      {
         this.channelFillPasswordLabel.enabled = this.channelRetypePasswordLabel.enabled = this.channelPasswordInput.enabled = this.channelRetypePasswordInput.enabled = this.channelPasswordCheckBox.selected;
         invalidate(UPDATE_PASSWORD_TEXT);
      }
      
      private function createChannel() : void
      {
         var _loc1_:String = this.channelNameInput.text;
         var _loc2_:Boolean = this.channelPasswordCheckBox.selected;
         var _loc3_:String = !!_loc2_ ? this.channelPasswordInput.text : null;
         var _loc4_:String = !!_loc2_ ? this.channelRetypePasswordInput.text : null;
         dispatchEvent(new ChannelsFormEvent(ChannelsFormEvent.CREATE_CHANNEL,true,false,_loc1_,_loc3_,_loc4_));
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.isDefaultPrevented())
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         var _loc3_:uint = _loc2_.controllerIndex;
         if(_loc2_.navEquivalent == null)
         {
            if(_loc2_.code == Keyboard.ENTER)
            {
               this.handlePress(_loc3_);
               param1.handled = true;
            }
         }
         else if(_loc2_.code != Keyboard.SPACE)
         {
            switch(_loc2_.navEquivalent)
            {
               case NavigationCode.ENTER:
                  if(_loc2_.value == InputValue.KEY_DOWN)
                  {
                     this.handlePress(_loc3_);
                     param1.handled = true;
                  }
            }
         }
      }
      
      private function onChannelCreateButtonClickHandler(param1:ButtonEvent = null) : void
      {
         this.createChannel();
      }
      
      private function onChannelPasswordCheckBoxSelectHandler(param1:Event = null) : void
      {
         this.updateCheckBoxSelected();
      }
   }
}
