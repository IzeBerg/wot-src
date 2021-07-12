package net.wg.gui.rally.views.room
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.gui.rally.interfaces.IChatSectionWithDescription;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.infrastructure.interfaces.IUserProps;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class ChatSectionWithDescription extends BaseChatSection implements IChatSectionWithDescription
   {
      
      protected static const INVALID_EDIT_MODE:String = "invalidEditMode";
       
      
      public var editDescriptionButton:IButtonIconLoader;
      
      public var editCommitButton:IButtonIconLoader;
      
      public var descriptionTF:TextField;
      
      public var descriptionInput:TextInput;
      
      protected var _inEditMode:Boolean = false;
      
      public function ChatSectionWithDescription()
      {
         super();
      }
      
      override public function getComponentForFocus() : InteractiveObject
      {
         return this.descriptionInput;
      }
      
      override public function setDescription(param1:String) : void
      {
         super.setDescription(param1);
         this.descriptionInput.text = param1;
         this.updateDescriptionTF(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.descriptionInput.editable = false;
         this.descriptionInput.defaultTextFormat = this.descriptionInput.textField.getTextFormat();
         this.descriptionInput.defaultTextFormat.italic = false;
         this.descriptionInput.defaultTextFormat.color = 5855568;
         this.editDescriptionButton.visible = false;
         this.editCommitButton.visible = false;
         this.editCommitButton.addEventListener(ButtonEvent.CLICK,this.onEditCommitClick);
         this.editCommitButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_ENTERWHITE;
         this.editDescriptionButton.addEventListener(ButtonEvent.CLICK,this.onEditClick);
         this.editDescriptionButton.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_PEN;
         this.descriptionInput.addEventListener(InputEvent.INPUT,this.descriptionInputHandler);
         this.changeTextFormat();
         this.descriptionTF.addEventListener(MouseEvent.ROLL_OVER,this.onDescriptionOver);
         this.descriptionTF.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(!this._inEditMode)
            {
               _loc1_ = Boolean(_rallyData) ? _rallyData.description : "";
               this.descriptionInput.text = _loc1_;
               _previousComment = _loc1_;
               this.updateDescriptionTF(_previousComment);
            }
         }
         if(isInvalid(INVALID_EDIT_MODE))
         {
            _loc2_ = Boolean(_rallyData) ? Boolean(_rallyData.isCommander) : Boolean(false);
            this.editDescriptionButton.visible = _loc2_ && !this._inEditMode;
            this.editCommitButton.visible = _loc2_ && this._inEditMode;
            this.descriptionInput.visible = this.descriptionInput.editable = _loc2_ && this._inEditMode;
            this.descriptionTF.visible = !this.descriptionInput.visible;
         }
      }
      
      override protected function onDispose() : void
      {
         this.editCommitButton.removeEventListener(ButtonEvent.CLICK,this.onEditCommitClick);
         this.editDescriptionButton.removeEventListener(ButtonEvent.CLICK,this.onEditClick);
         this.descriptionInput.removeEventListener(InputEvent.INPUT,this.descriptionInputHandler);
         this.descriptionTF.removeEventListener(MouseEvent.ROLL_OVER,this.onDescriptionOver);
         this.descriptionTF.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         this.descriptionTF = null;
         this.editDescriptionButton.dispose();
         this.editDescriptionButton = null;
         this.editCommitButton.dispose();
         this.editCommitButton = null;
         this.descriptionInput.dispose();
         this.descriptionInput = null;
         super.onDispose();
      }
      
      public function enableEditCommitButton(param1:Boolean) : void
      {
         if(this.editCommitButton && this.editDescriptionButton)
         {
            this.editDescriptionButton.enabled = param1;
            this.editCommitButton.enabled = param1;
         }
      }
      
      protected function updateDescription(param1:Boolean = false) : void
      {
         if(param1)
         {
            _previousComment = this.descriptionInput.text = StringUtils.trim(this.descriptionInput.text);
            this.updateDescriptionTF(_previousComment);
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.EDIT_RALLY_DESCRIPTION,this.descriptionInput.text));
         }
         else
         {
            this.descriptionInput.text = _previousComment;
            this.updateDescriptionTF(_previousComment);
         }
         this._inEditMode = false;
         invalidate(INVALID_EDIT_MODE);
      }
      
      protected function changeTextFormat() : void
      {
         var _loc1_:TextFormat = this.descriptionInput.textField.getTextFormat();
         _loc1_.italic = false;
         _loc1_.color = 5855568;
         this.descriptionTF.setTextFormat(this.descriptionInput.textField.getTextFormat());
      }
      
      private function updateDescriptionTF(param1:String) : void
      {
         var _loc2_:IUserProps = App.utils.commons.getUserProps(param1);
         App.utils.commons.formatPlayerName(this.descriptionTF,_loc2_);
         if(!this.descriptionTF.text && rallyData)
         {
            this.descriptionTF.text = !!rallyData.isCommander ? CYBERSPORT.WINDOW_UNIT_DESCRIPTIONDEFAULT : Values.EMPTY_STR;
            this.changeAlign(true);
         }
         else
         {
            this.changeAlign(false);
         }
      }
      
      private function changeAlign(param1:Boolean) : void
      {
         var _loc2_:TextFormat = this.descriptionTF.getTextFormat();
         _loc2_.align = !!param1 ? TextFormatAlign.RIGHT : TextFormatAlign.LEFT;
         this.descriptionTF.setTextFormat(_loc2_);
      }
      
      override public function set rallyData(param1:IRallyVO) : void
      {
         if(param1 == null)
         {
            return;
         }
         super.rallyData = param1;
         invalidate(INVALID_EDIT_MODE);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.F1 && _loc2_.value == InputValue.KEY_UP && this.descriptionInput.focused > 0)
         {
            param1.handled = true;
            return;
         }
         super.handleInput(param1);
      }
      
      private function onDescriptionOver(param1:MouseEvent) : void
      {
         var _loc2_:String = Boolean(_rallyData) ? _rallyData.description : "";
         if(_loc2_)
         {
            App.toolTipMgr.show(_loc2_);
         }
      }
      
      private function onEditClick(param1:ButtonEvent) : void
      {
         this._inEditMode = true;
         invalidate(INVALID_EDIT_MODE);
         App.utils.scheduler.scheduleOnNextFrame(updateFocus);
      }
      
      private function onEditCommitClick(param1:ButtonEvent) : void
      {
         this.updateDescription(true);
      }
      
      private function descriptionInputHandler(param1:InputEvent) : void
      {
         if(param1.details.code == Keyboard.ESCAPE && param1.details.value == InputValue.KEY_DOWN && this._inEditMode)
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            this.updateDescription(false);
         }
         if(param1.details.code == Keyboard.ENTER && param1.details.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            this.updateDescription(true);
         }
      }
   }
}
