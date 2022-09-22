package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.lobby.vehicleCustomization.events.propertiesSheet.ProjectionControlsEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.controls.ButtonGroup;
   
   public class CustomizationSheetProjectionControls extends UIComponentEx
   {
      
      private static const PROJECTION_BTNS_GROUP:String = "projectionGroup";
       
      
      public var rotationBtn:CustomizationSheetProjectionBtn = null;
      
      public var scaleBtn:CustomizationSheetProjectionBtn = null;
      
      public var moveBtn:CustomizationSheetProjectionBtn = null;
      
      private var _btnsGroup:ButtonGroup = null;
      
      private var _editMode:Boolean = false;
      
      private var _editInProgress:Boolean = false;
      
      public function CustomizationSheetProjectionControls()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._btnsGroup = ButtonGroup.getGroup(PROJECTION_BTNS_GROUP,this);
         this.addButtonToGroup(this.moveBtn);
         this.addButtonToGroup(this.scaleBtn);
         this.addButtonToGroup(this.rotationBtn);
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         this._btnsGroup.addEventListener(Event.CHANGE,this.onSelectedBtnChangeHandler);
      }
      
      private function addButtonToGroup(param1:SoundButton) : void
      {
         param1.toggle = true;
         param1.allowDeselect = true;
         this._btnsGroup.addButton(param1);
         param1.groupName = PROJECTION_BTNS_GROUP;
      }
      
      override protected function onDispose() : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         this._btnsGroup.removeEventListener(Event.CHANGE,this.onSelectedBtnChangeHandler);
         this._btnsGroup.dispose();
         this._btnsGroup = null;
         this.rotationBtn.dispose();
         this.rotationBtn = null;
         this.scaleBtn.dispose();
         this.scaleBtn = null;
         this.moveBtn.dispose();
         this.moveBtn = null;
         super.onDispose();
      }
      
      private function onSelectedBtnChangeHandler(param1:Event) : void
      {
         this._editMode = this._btnsGroup.selectedIndex != Values.DEFAULT_INT;
         this.interactionTypeUpdate();
      }
      
      private function onStageMouseUpHandler(param1:MouseEvent) : void
      {
         if(this._editMode && this._editInProgress)
         {
            this._editInProgress = false;
            this.interactionStatusUpdate();
         }
      }
      
      private function onStageMouseDownHandler(param1:MouseEvent) : void
      {
         if(this._editMode && param1.target != this.moveBtn && param1.target != this.rotationBtn && param1.target != this.scaleBtn)
         {
            this._editInProgress = true;
            this.interactionStatusUpdate();
         }
      }
      
      public function hide() : void
      {
         visible = false;
         this._editMode = false;
         this._editInProgress = false;
         if(this._btnsGroup)
         {
            this._btnsGroup.clearSelectedButton();
         }
         this.interactionTypeUpdate();
      }
      
      private function interactionStatusUpdate() : void
      {
         dispatchEvent(new ProjectionControlsEvent(ProjectionControlsEvent.INTERACTION_STAUTS,this._editInProgress));
      }
      
      private function interactionTypeUpdate() : void
      {
         if(this._btnsGroup)
         {
            dispatchEvent(new ProjectionControlsEvent(ProjectionControlsEvent.INTERACTION_TYPE,this._editMode,this._btnsGroup.selectedIndex));
         }
      }
      
      public function show() : void
      {
         visible = true;
      }
   }
}
