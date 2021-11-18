package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.VO.TankmanCardVO;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class TankmanCard extends UIComponentEx
   {
      
      private static const ROLE_ICON_OFFSET:int = 10;
      
      private static const VEHICLE_TF_LOCKED_SHIFT_Y:int = -2;
       
      
      public var backFlag:MovieClip;
      
      public var faceIcon:UILoaderAlt;
      
      public var rankIcon:UILoaderAlt;
      
      public var rankLabelTF:TextField;
      
      public var nameLabelTF:TextField;
      
      public var vehicleLabelTF:TextField;
      
      public var rankTF:TextField;
      
      public var nameTF:TextField;
      
      public var vehicleTF:TextField;
      
      public var roleIcon:UILoaderAlt;
      
      private var _model:TankmanCardVO;
      
      private var _isVehicleLocked:Boolean = false;
      
      private var _vehicleTFStartY:Number;
      
      public function TankmanCard()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.rankLabelTF.htmlText = MENU.TANKMANPERSONALCASE_RANK;
         this.nameLabelTF.htmlText = MENU.TANKMANPERSONALCASE_NAME;
         this.vehicleLabelTF.htmlText = MENU.TANKMANPERSONALCASE_CREW;
         this._vehicleTFStartY = this.vehicleTF.y;
      }
      
      override protected function onDispose() : void
      {
         this._model = null;
         this.faceIcon.dispose();
         this.faceIcon = null;
         this.rankIcon.dispose();
         this.rankIcon = null;
         this.roleIcon.dispose();
         this.roleIcon = null;
         this.rankLabelTF = null;
         this.nameLabelTF = null;
         this.vehicleLabelTF = null;
         this.rankTF = null;
         this.nameTF = null;
         this.vehicleTF = null;
         this.backFlag = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._model && isInvalid(InvalidationType.DATA))
         {
            this.rankTF.htmlText = this._model.rank;
            App.utils.commons.truncateTextFieldText(this.nameTF,this._model.name,true,true);
            if(this._model.vehicle != null && this._model.vehicle != Values.EMPTY_STR)
            {
               this.vehicleTF.htmlText = this._model.vehicle;
               this.vehicleLabelTF.visible = this.vehicleTF.visible = true;
               this.vehicleTF.y = !!this.isVehicleLocked ? Number(this._vehicleTFStartY + VEHICLE_TF_LOCKED_SHIFT_Y) : Number(this._vehicleTFStartY);
            }
            else
            {
               this.vehicleLabelTF.visible = this.vehicleTF.visible = false;
            }
            this.backFlag.gotoAndPlay(this._model.nation);
            this.faceIcon.source = this._model.faceIcon;
            this.rankIcon.source = this._model.rankIcon;
            if(this._model.roleIcon.length > 0)
            {
               this.roleIcon.visible = true;
               this.roleIcon.source = this._model.roleIcon;
               this.roleIcon.x = this.vehicleTF.x + this.vehicleTF.textWidth + ROLE_ICON_OFFSET;
            }
            else
            {
               this.roleIcon.visible = false;
            }
         }
      }
      
      public function get model() : TankmanCardVO
      {
         return this._model;
      }
      
      public function set model(param1:TankmanCardVO) : void
      {
         this._model = param1;
         invalidateData();
      }
      
      public function get isVehicleLocked() : Boolean
      {
         return this._isVehicleLocked;
      }
      
      public function set isVehicleLocked(param1:Boolean) : void
      {
         if(this._isVehicleLocked != param1)
         {
            this._isVehicleLocked = param1;
            invalidateData();
         }
      }
   }
}
