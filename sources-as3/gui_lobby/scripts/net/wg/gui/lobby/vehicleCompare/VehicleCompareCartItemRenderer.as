package net.wg.gui.lobby.vehicleCompare
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.ButtonIconTransparent;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareCartItemVO;
   import net.wg.gui.lobby.vehicleCompare.events.VehicleCompareCartEvent;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehicleCompareCartItemRenderer extends TableRenderer
   {
      
      private static const LEVEL_POS:int = 115;
      
      private static const VEH_TYPE_MIDDLE_X:int = 73;
       
      
      public var flagLoader:UILoaderAlt;
      
      public var tankIcon:UILoaderAlt;
      
      public var vehicleTypeIcon:Image;
      
      public var levelIcon:MovieClip;
      
      public var vehicleNameTF:TextField;
      
      public var complectationTF:TextField;
      
      public var removeBtn:ButtonIconTransparent = null;
      
      private var _model:VehicleCompareCartItemVO;
      
      private var _commons:ICommons;
      
      public function VehicleCompareCartItemRenderer()
      {
         super();
         this._commons = App.utils.commons;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._model = VehicleCompareCartItemVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.removeBtn.iconSource = RES_ICONS.MAPS_ICONS_CLANS_INVITESWINDOW_CROSS;
         this.removeBtn.addEventListener(ButtonEvent.CLICK,this.onRemoveBtnClickHandler);
         this.complectationTF.addEventListener(MouseEvent.ROLL_OVER,this.onComplectationRollOverHandler);
         this.complectationTF.addEventListener(MouseEvent.ROLL_OUT,this.onComplectationRollOutHandler);
         this.vehicleTypeIcon.addEventListener(Event.CHANGE,this.onVehicleTypeIconChangeHandler);
         App.utils.commons.updateChildrenMouseEnabled(this,false);
         this.removeBtn.mouseEnabled = true;
         this.removeBtn.mouseEnabledOnDisabled = true;
         this.complectationTF.mouseEnabled = true;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._model)
            {
               this.vehicleNameTF.htmlText = this._model.vehicleName;
               this._commons.truncateTextFieldText(this.complectationTF,this._model.complectation);
               this.vehicleTypeIcon.source = this._model.typeStr;
               this.levelIcon.gotoAndStop(this._model.level);
               this.levelIcon.x = LEVEL_POS - (this.levelIcon.width >> 1);
               this.flagLoader.source = this._model.nation;
               this.tankIcon.source = this._model.smallIconPath;
               this.removeBtn.tooltip = this._model.removeBtnTooltip;
               this.removeBtn.enabled = this._model.removeBtnEnabled;
            }
            _loc1_ = this._model != null;
            this.vehicleNameTF.visible = _loc1_;
            this.complectationTF.visible = _loc1_;
            this.vehicleTypeIcon.visible = _loc1_;
            this.levelIcon.visible = _loc1_;
            this.flagLoader.visible = _loc1_;
            this.tankIcon.visible = _loc1_;
            this.removeBtn.visible = _loc1_;
            this.enabled = _loc1_;
         }
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.removeItem);
         this.removeBtn.removeEventListener(ButtonEvent.CLICK,this.onRemoveBtnClickHandler);
         this.removeBtn.dispose();
         this.removeBtn = null;
         this.complectationTF.removeEventListener(MouseEvent.ROLL_OVER,this.onComplectationRollOverHandler);
         this.complectationTF.removeEventListener(MouseEvent.ROLL_OUT,this.onComplectationRollOutHandler);
         this.complectationTF = null;
         this.flagLoader.dispose();
         this.flagLoader = null;
         this.tankIcon.dispose();
         this.tankIcon = null;
         this.vehicleNameTF = null;
         this.levelIcon = null;
         this.vehicleTypeIcon.removeEventListener(Event.CHANGE,this.onVehicleTypeIconChangeHandler);
         this.vehicleTypeIcon.dispose();
         this.vehicleTypeIcon = null;
         this._commons = null;
         this._model = null;
         super.onDispose();
      }
      
      private function removeItem() : void
      {
         dispatchEvent(new VehicleCompareCartEvent(this._model.index));
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = param1;
      }
      
      private function onVehicleTypeIconChangeHandler(param1:Event) : void
      {
         this.vehicleTypeIcon.x = VEH_TYPE_MIDDLE_X - (this.vehicleTypeIcon.width >> 1);
      }
      
      private function onComplectationRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onComplectationRollOverHandler(param1:MouseEvent) : void
      {
         if(this._model && this._model.complectation != this.complectationTF.text)
         {
            App.toolTipMgr.show(this._model.complectation);
         }
      }
      
      private function onRemoveBtnClickHandler(param1:ButtonEvent) : void
      {
         App.utils.scheduler.scheduleOnNextFrame(this.removeItem);
      }
   }
}
