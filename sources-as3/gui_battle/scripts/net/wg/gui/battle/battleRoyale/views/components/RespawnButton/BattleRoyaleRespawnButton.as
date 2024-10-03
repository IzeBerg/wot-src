package net.wg.gui.battle.battleRoyale.views.components.RespawnButton
{
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.buttons.BattleToolTipButton;
   import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleEquipmentButtonGlow;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
   import scaleform.gfx.TextFieldEx;
   
   public class BattleRoyaleRespawnButton extends BattleToolTipButton implements IConsumablesButton
   {
      
      private static const GLOW_VALIDATION_FLAG:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const STATUS_VALIDATION_FLAG:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const EMPTY_FLAG:uint = 1;
      
      private static const STATUS_AVAILABLE:uint = 2;
      
      private static const NEGATIVE_QUANTITY:Number = -1;
       
      
      public var iconWrapper:RespawnIcon = null;
      
      public var itemQuantityTf:TextField = null;
      
      public var glow:IBattleEquipmentButtonGlow = null;
      
      private var _glowId:int = 0;
      
      private var _showGlow:Boolean = false;
      
      private var _consumablesVo:ConsumablesVO;
      
      private var _quantity:int = -1;
      
      private var _statusMask:uint = 2;
      
      public function BattleRoyaleRespawnButton()
      {
         this._consumablesVo = new ConsumablesVO();
         super();
         this.isAvailable = true;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(STATUS_VALIDATION_FLAG))
         {
            this.iconWrapper.setIsEnabled(this.isAvailable);
            this.itemQuantityTf.visible = this.isAvailable;
         }
         if(isInvalid(GLOW_VALIDATION_FLAG))
         {
            if(this._showGlow)
            {
               this.glow.showGlow(this._glowId);
               this._showGlow = false;
            }
            else
            {
               this.glow.hideGlow();
            }
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.itemQuantityTf.text = this._quantity.toString();
         }
      }
      
      override protected function onDispose() : void
      {
         this.iconWrapper.dispose();
         this.iconWrapper = null;
         this.glow.dispose();
         this.glow = null;
         this.itemQuantityTf = null;
         this._consumablesVo = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         isAllowedToShowToolTipOnDisabledState = true;
         enabled = false;
         this.icon = RES_ICONS.MAPS_ICONS_BATTLEROYALE_ARTEFACT_RESPAWN;
         TextFieldEx.setNoTranslate(this.itemQuantityTf,true);
      }
      
      public function clearColorTransform() : void
      {
      }
      
      public function clearCoolDownTime() : void
      {
      }
      
      public function hideGlow() : void
      {
         this._showGlow = false;
         invalidate(GLOW_VALIDATION_FLAG);
      }
      
      public function setColorTransform(param1:ColorTransform) : void
      {
      }
      
      public function setCoolDownPosAsPercent(param1:Number) : void
      {
      }
      
      public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int = 1) : void
      {
      }
      
      public function setTimerSnapshot(param1:int, param2:Boolean) : void
      {
      }
      
      public function showGlow(param1:int) : void
      {
         this._glowId = param1;
         this._showGlow = true;
         invalidate(GLOW_VALIDATION_FLAG);
      }
      
      public function updateLevelInformation(param1:int) : void
      {
      }
      
      public function updateLockedInformation(param1:int, param2:String) : void
      {
      }
      
      public function setStage(param1:int) : void
      {
      }
      
      public function get consumablesVO() : ConsumablesVO
      {
         return this._consumablesVo;
      }
      
      public function set icon(param1:String) : void
      {
      }
      
      public function set key(param1:Number) : void
      {
      }
      
      public function set quantity(param1:int) : void
      {
         param1 = param1 < 0 ? int(NEGATIVE_QUANTITY) : int(param1);
         if(param1 == this._quantity)
         {
            return;
         }
         if(param1 == 0)
         {
            this.status |= EMPTY_FLAG;
         }
         else
         {
            this.status &= ~EMPTY_FLAG;
         }
         this._quantity = param1;
         invalidateData();
      }
      
      public function set activated(param1:Boolean) : void
      {
      }
      
      public function get showConsumableBorder() : Boolean
      {
         return false;
      }
      
      public function set showConsumableBorder(param1:Boolean) : void
      {
      }
      
      public function set isReplay(param1:Boolean) : void
      {
      }
      
      public function get isAvailable() : Boolean
      {
         return (this._statusMask & STATUS_AVAILABLE) > 0;
      }
      
      public function set isAvailable(param1:Boolean) : void
      {
         if(param1)
         {
            this.status |= STATUS_AVAILABLE;
         }
         else
         {
            this.status &= ~STATUS_AVAILABLE;
         }
      }
      
      private function get status() : uint
      {
         return this._statusMask;
      }
      
      private function set status(param1:uint) : void
      {
         var _loc2_:uint = param1 ^ this._statusMask;
         if(_loc2_ == 0)
         {
            return;
         }
         this._statusMask = param1;
         invalidate(STATUS_VALIDATION_FLAG);
      }
   }
}
