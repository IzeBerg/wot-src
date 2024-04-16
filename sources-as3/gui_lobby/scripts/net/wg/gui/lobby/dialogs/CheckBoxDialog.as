package net.wg.gui.lobby.dialogs
{
   import flash.events.Event;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.infrastructure.base.meta.ICheckBoxDialogMeta;
   import net.wg.infrastructure.base.meta.impl.CheckBoxDialogMeta;
   import scaleform.clik.constants.InvalidationType;
   
   public class CheckBoxDialog extends CheckBoxDialogMeta implements ICheckBoxDialogMeta
   {
      
      private static const CHECK_BOX_GAP:Number = 4;
       
      
      public var checkBox:CheckBox;
      
      private var _checkBoxLabel:String = "";
      
      private var _checkBoxSelected:Boolean;
      
      private var _checkBoxEnabled:Boolean = true;
      
      public function CheckBoxDialog()
      {
         super();
      }
      
      public function as_setCheckBoxLabel(param1:String) : void
      {
         this.checkBoxLabel = param1;
      }
      
      public function as_setCheckBoxSelected(param1:Boolean) : void
      {
         this.checkBoxSelected = param1;
      }
      
      public function as_setCheckBoxEnabled(param1:Boolean) : void
      {
         this.checkBoxEnabled = param1;
      }
      
      public function get checkBoxLabel() : String
      {
         return this._checkBoxLabel;
      }
      
      public function set checkBoxLabel(param1:String) : void
      {
         if(param1 == this._checkBoxLabel)
         {
            return;
         }
         this._checkBoxLabel = param1;
         invalidate(InvalidationType.SETTINGS);
      }
      
      public function get checkBoxSelected() : Boolean
      {
         return this._checkBoxSelected;
      }
      
      public function set checkBoxSelected(param1:Boolean) : void
      {
         if(param1 == this._checkBoxSelected)
         {
            return;
         }
         this._checkBoxSelected = param1;
         invalidate(InvalidationType.SETTINGS);
         onCheckBoxChange(param1);
      }
      
      public function get checkBoxEnabled() : Boolean
      {
         return this._checkBoxEnabled;
      }
      
      public function set checkBoxEnabled(param1:Boolean) : void
      {
         if(param1 == this._checkBoxEnabled)
         {
            return;
         }
         this._checkBoxEnabled = param1;
         invalidate(InvalidationType.SETTINGS);
      }
      
      override protected function onDispose() : void
      {
         if(this.checkBox)
         {
            this.checkBox.removeEventListener(Event.SELECT,this.onCheckBoxChangeHandler);
            this.checkBox.dispose();
            this.checkBox = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.checkBox)
         {
            this.checkBox.addEventListener(Event.SELECT,this.onCheckBoxChangeHandler);
         }
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.SETTINGS))
         {
            this.refreshStyles();
            invalidateLayout();
         }
         super.draw();
         if(this.checkBox)
         {
            this.checkBox.validateNow();
         }
      }
      
      override protected function applyLayout() : void
      {
         super.applyLayout();
         if(this.checkBox)
         {
            this.checkBox.validateNow();
            this.checkBox.y = this.getBackgroundActualHeight() - this.checkBox.height - CHECK_BOX_GAP;
         }
      }
      
      override protected function getBackgroundActualHeight() : Number
      {
         var _loc1_:Number = super.getBackgroundActualHeight();
         if(this.checkBox)
         {
            this.checkBox.validateNow();
            _loc1_ += this.checkBox.height + (CHECK_BOX_GAP << 1);
         }
         return _loc1_;
      }
      
      protected function refreshStyles() : void
      {
         if(this.checkBox)
         {
            this.checkBox.label = this._checkBoxLabel;
            this.checkBox.enabled = this._checkBoxEnabled;
            this.checkBox.selected = this._checkBoxSelected;
         }
      }
      
      protected function onCheckBoxChangeHandler(param1:Event) : void
      {
         this.checkBoxSelected = this.checkBox.selected;
      }
   }
}
