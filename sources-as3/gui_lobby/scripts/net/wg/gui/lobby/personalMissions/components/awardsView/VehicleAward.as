package net.wg.gui.lobby.personalMissions.components.awardsView
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionsItemSlotVO;
   import net.wg.gui.lobby.personalMissions.data.VehicleAwardVO;
   import net.wg.gui.lobby.personalMissions.events.AwardEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.MouseEventEx;
   
   public class VehicleAward extends UIComponentEx implements IUpdatable
   {
      
      private static const INVALID_COMPACT:String = "invalidCompact";
      
      private static const COMPACT_RADIO_Y:int = -75;
      
      private static const COMPACT_TRACK_Y:int = 14;
      
      private static const COMPACT_BODY_Y:int = -22;
      
      private static const RADIO_Y:int = -60;
      
      private static const TRACK_Y:int = 44;
      
      private static const BODY_Y:int = -7;
      
      private static const GUN_Y:int = -164;
      
      private static const ENGINE_Y:int = -111;
      
      private static const ALLIANCE_LEFT_SLOTS_X:int = -404;
      
      private static const ALLIANCES_RIGHT_SLOTS_X:int = 415;
      
      private static const ALLIANCE_LEFT_SLOTS_COMPACT_X:int = -404;
      
      private static const ALLIANCES_RIGHT_SLOTS_COMPACT_X:int = 315;
      
      private static const TOP_ALLIANCES_Y:int = -105;
      
      private static const TOP_ALLIANCES_COMPACT_Y:int = -140;
      
      private static const BOTTOM_ALLIANCES_Y:int = 9;
      
      private static const BOTTOM_ALLIANCES_COMPACT_Y:int = -40;
      
      private static const LEFT_SLOT_X:int = -404;
      
      private static const RIGHT_SLOTS_X:int = 324;
      
      private static const OBJ260_LEFT_SLOTS_X:int = -404;
      
      private static const OBJ260_RIGHT_SLOTS_X:int = 507;
      
      private static const OBJ260_COMPACT_LEFT_SLOTS_X:int = -387;
      
      private static const OBJ260_COMPACT_RIGHT_SLOTS_X:int = 343;
      
      private static const OBJ260_COMPACT_X_SHIFT:int = -6;
      
      private static const SECOND_COMPANY_X_SHIFT:int = -45;
      
      private static const SECOND_COMPANY_COMPACT_X_SHIFT:int = -8;
      
      private static const OBJ260_X_SHIFT:int = -92;
      
      private static const OBJ260_ID:String = "obj260";
      
      private static const EXCALIBUR_ID:String = "excalibur";
      
      private static const CHIMERA_ID:String = "chimera";
      
      private static const OBJ729_ID:String = "obj729";
      
      private static const LABEL_FADEIN:String = "fadeIn";
      
      private static const LABEL_FADEOUT:String = "fadeOut";
       
      
      public var vehicleSlot:PersonalMissionsVehicleSlot = null;
      
      public var animatorMc:MovieClip = null;
      
      private var _isCompact:Boolean = false;
      
      private var _model:VehicleAwardVO = null;
      
      private var _slotsMapping:Vector.<PersonalMissionsItemSlot> = null;
      
      private var _slotsCount:int = 0;
      
      private var _currentVehicle:String = null;
      
      public function VehicleAward()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehicleSlot.addEventListener(AwardEvent.VEHICLE_LOADED,this.onVehicleSlotVehicleLoadedHandler);
         this.vehicleSlot.addEventListener(MouseEvent.CLICK,this.onVehicleSlotClickHandler);
         this.animatorMc.blankMc.addChild(this.vehicleSlot);
         this.animatorMc.addFrameScript(this.animatorMc.totalFrames - 1,this.onFadeOutCompleteHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:PersonalMissionsItemSlot = null;
         var _loc2_:int = 0;
         super.draw();
         if(this._model && isInvalid(InvalidationType.DATA))
         {
            this.clearItemSlots();
            this._slotsCount = this._model.slots.length;
            this._slotsMapping = new Vector.<PersonalMissionsItemSlot>(this._slotsCount);
            _loc2_ = 0;
            while(_loc2_ < this._slotsCount)
            {
               _loc1_ = App.utils.classFactory.getComponent(Linkages.ITEM_SLOT_80X80_RENDERER,PersonalMissionsItemSlot);
               _loc1_.visible = false;
               this._slotsMapping[_loc2_] = _loc1_;
               this.animatorMc.blankMc.addChild(_loc1_);
               _loc2_++;
            }
            if(this._currentVehicle != this._model.getVehicleId())
            {
               this._currentVehicle = this._model.getVehicleId();
               this.animatorMc.gotoAndPlay(LABEL_FADEOUT);
            }
            else
            {
               this.onFadeOutCompleteHandler();
            }
         }
         if(isInvalid(INVALID_COMPACT))
         {
            this.updatePositions();
         }
      }
      
      override protected function onDispose() : void
      {
         this.animatorMc.addFrameScript(this.animatorMc.totalFrames - 1,null);
         this.animatorMc.stop();
         this.vehicleSlot.removeEventListener(AwardEvent.VEHICLE_LOADED,this.onVehicleSlotVehicleLoadedHandler);
         this.vehicleSlot.removeEventListener(MouseEvent.CLICK,this.onVehicleSlotClickHandler);
         this.vehicleSlot.dispose();
         this.vehicleSlot = null;
         this.clearItemSlots();
         this.animatorMc = null;
         this._model = null;
         super.onDispose();
      }
      
      public function switchCompact(param1:Boolean) : void
      {
         if(this._isCompact != param1)
         {
            this._isCompact = param1;
            this.vehicleSlot.switchCompact(this._isCompact);
            invalidate(INVALID_COMPACT);
         }
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null && param1 != this._model)
         {
            this._model = VehicleAwardVO(param1);
            invalidateData();
         }
      }
      
      private function updatePositions() : void
      {
         var _loc1_:PersonalMissionsItemSlot = null;
         var _loc2_:PersonalMissionsItemSlot = null;
         var _loc3_:PersonalMissionsItemSlot = null;
         var _loc4_:PersonalMissionsItemSlot = null;
         var _loc5_:PersonalMissionsItemSlot = null;
         var _loc6_:PersonalMissionsItemSlot = null;
         var _loc7_:PersonalMissionsItemSlot = null;
         var _loc8_:PersonalMissionsItemSlot = null;
         var _loc9_:PersonalMissionsItemSlot = null;
         if(this._slotsCount == 0)
         {
            return;
         }
         this.animatorMc.x = 0;
         if(this._currentVehicle == EXCALIBUR_ID || this._currentVehicle == CHIMERA_ID || this._currentVehicle == OBJ729_ID)
         {
            _loc1_ = this._slotsMapping[0];
            _loc2_ = this._slotsMapping[1];
            _loc3_ = this._slotsMapping[2];
            _loc4_ = this._slotsMapping[3];
            _loc1_.x = _loc2_.x = !!this._isCompact ? Number(ALLIANCE_LEFT_SLOTS_COMPACT_X) : Number(ALLIANCE_LEFT_SLOTS_X);
            _loc3_.x = _loc4_.x = !!this._isCompact ? Number(ALLIANCES_RIGHT_SLOTS_COMPACT_X) : Number(ALLIANCES_RIGHT_SLOTS_X);
            _loc1_.y = _loc3_.y = !!this._isCompact ? Number(TOP_ALLIANCES_COMPACT_Y) : Number(TOP_ALLIANCES_Y);
            _loc2_.y = _loc4_.y = !!this._isCompact ? Number(BOTTOM_ALLIANCES_COMPACT_Y) : Number(BOTTOM_ALLIANCES_Y);
            this.animatorMc.x = !!this._isCompact ? Number(SECOND_COMPANY_COMPACT_X_SHIFT) : Number(SECOND_COMPANY_X_SHIFT);
         }
         else
         {
            _loc5_ = this._slotsMapping[0];
            _loc6_ = this._slotsMapping[1];
            _loc7_ = this._slotsMapping[2];
            _loc8_ = this._slotsMapping[3];
            _loc9_ = this._slotsMapping[4];
            _loc6_.y = !!this._isCompact ? Number(COMPACT_RADIO_Y) : Number(RADIO_Y);
            _loc9_.y = !!this._isCompact ? Number(COMPACT_BODY_Y) : Number(BODY_Y);
            _loc7_.y = !!this._isCompact ? Number(COMPACT_TRACK_Y) : Number(TRACK_Y);
            _loc5_.y = GUN_Y;
            _loc8_.y = ENGINE_Y;
            if(this._currentVehicle == OBJ260_ID)
            {
               _loc7_.x = _loc6_.x = _loc5_.x = !!this._isCompact ? Number(OBJ260_COMPACT_LEFT_SLOTS_X) : Number(OBJ260_LEFT_SLOTS_X);
               _loc9_.x = _loc8_.x = !!this._isCompact ? Number(OBJ260_COMPACT_RIGHT_SLOTS_X) : Number(OBJ260_RIGHT_SLOTS_X);
               this.animatorMc.x = !!this._isCompact ? Number(OBJ260_COMPACT_X_SHIFT) : Number(OBJ260_X_SHIFT);
            }
            else
            {
               _loc7_.x = _loc6_.x = _loc5_.x = LEFT_SLOT_X;
               _loc9_.x = _loc8_.x = RIGHT_SLOTS_X;
            }
         }
      }
      
      private function clearItemSlots() : void
      {
         var _loc1_:PersonalMissionsItemSlot = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._slotsCount)
         {
            _loc1_ = this._slotsMapping[_loc2_];
            this.animatorMc.blankMc.removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
            _loc2_++;
         }
         if(this._slotsMapping != null)
         {
            this._slotsMapping.splice(0,this._slotsMapping.length);
            this._slotsMapping = null;
         }
         this._slotsCount = 0;
      }
      
      private function onFadeOutCompleteHandler() : void
      {
         var _loc2_:int = 0;
         this.animatorMc.stop();
         this.updatePositions();
         var _loc1_:Vector.<PersonalMissionsItemSlotVO> = this._model.slots;
         if(_loc1_)
         {
            _loc2_ = 0;
            while(_loc2_ < this._slotsCount)
            {
               this._slotsMapping[_loc2_].setData(_loc1_[_loc2_]);
               this._slotsMapping[_loc2_].visible = true;
               _loc2_++;
            }
         }
         this.vehicleSlot.update(this._model.vehicleSlotData);
      }
      
      private function onVehicleSlotVehicleLoadedHandler(param1:AwardEvent) : void
      {
         this.animatorMc.gotoAndPlay(LABEL_FADEIN);
      }
      
      private function onVehicleSlotClickHandler(param1:MouseEvent) : void
      {
         if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new AwardEvent(AwardEvent.VEHICLE_PREVIEW));
         }
      }
   }
}
