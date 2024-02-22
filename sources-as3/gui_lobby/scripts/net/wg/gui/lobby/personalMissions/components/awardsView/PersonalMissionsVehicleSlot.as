package net.wg.gui.lobby.personalMissions.components.awardsView
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionsVehicleSlotVO;
   import net.wg.gui.lobby.personalMissions.events.AwardEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalMissionsVehicleSlot extends UIComponentEx implements IUpdatable
   {
      
      private static const INVALID_PATH_VISIBLE:String = "invalidPathVisible";
      
      private static const STATE_SMALL:String = "_small";
       
      
      public var vehicleImg:UILoaderAlt = null;
      
      public var pathImg:UILoaderAlt = null;
      
      public var hitAreaMc:Sprite = null;
      
      private var _model:PersonalMissionsVehicleSlotVO = null;
      
      private var _isCompact:Boolean = false;
      
      private var _isPathVisible:Boolean = false;
      
      public function PersonalMissionsVehicleSlot()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         useHandCursor = buttonMode = true;
         this.vehicleImg.addEventListener(UILoaderEvent.COMPLETE,this.onVehicleImgCompleteHandler);
         this.vehicleImg.mouseEnabled = this.vehicleImg.mouseChildren = false;
         this.pathImg.mouseEnabled = this.pathImg.mouseChildren = false;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._model && isInvalid(InvalidationType.DATA))
         {
            this.vehicleImg.source = !!this._isCompact ? this._model.vehicleSmallImg : this._model.vehicleImg;
            this.pathImg.source = !!this._isCompact ? this._model.pathSmallImg : this._model.pathImg;
            gotoAndStop(this._model.vehicleId + (!!this._isCompact ? STATE_SMALL : ""));
            hitArea = this.hitAreaMc;
         }
         if(isInvalid(INVALID_PATH_VISIBLE))
         {
            this.pathImg.visible = this._isPathVisible;
         }
      }
      
      override protected function onDispose() : void
      {
         this.vehicleImg.removeEventListener(UILoaderEvent.COMPLETE,this.onVehicleImgCompleteHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.vehicleImg.dispose();
         this.vehicleImg = null;
         this.pathImg.dispose();
         this.pathImg = null;
         this.hitAreaMc = null;
         this._model = null;
         super.onDispose();
      }
      
      public function switchCompact(param1:Boolean) : void
      {
         if(this._isCompact != param1)
         {
            this._isCompact = param1;
            invalidateData();
         }
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null && this._model != param1)
         {
            this._model = PersonalMissionsVehicleSlotVO(param1);
            invalidateData();
         }
      }
      
      private function onVehicleImgCompleteHandler(param1:UILoaderEvent) : void
      {
         dispatchEvent(new AwardEvent(AwardEvent.VEHICLE_LOADED));
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._isPathVisible = false;
         invalidate(INVALID_PATH_VISIBLE);
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this._isPathVisible = true;
         invalidate(INVALID_PATH_VISIBLE);
      }
   }
}
