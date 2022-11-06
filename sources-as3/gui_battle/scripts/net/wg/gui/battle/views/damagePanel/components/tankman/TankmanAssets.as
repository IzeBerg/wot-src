package net.wg.gui.battle.views.damagePanel.components.tankman
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.views.damagePanel.DamagePanel;
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemClickArea;
   import net.wg.gui.battle.views.damagePanel.components.statusIndicator.StatusArrow;
   import net.wg.gui.battle.views.damagePanel.components.stunIndicator.StunArrow;
   import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelClickableItem;
   
   public class TankmanAssets implements IDamagePanelClickableItem
   {
      
      public static const Y_POS:int = 197;
      
      private static const TANKMAN_HIT_AREA_PADDING:int = 5;
      
      private static const X_STEP:int = 25;
      
      private static const X_OFFSET:int = -3;
      
      private static const STUN_ARROW_LINKAGE:String = "StunArrowUI";
      
      private static const BUFF_ARROW_LINKAGE:String = "BuffArrowUI";
      
      private static const X_STUN_OFFSET:int = 16;
      
      private static const Y_STUN_OFFSET:int = 23;
      
      private static const STUN_STATUS_ID:int = 0;
      
      private static const BUFF_STATUS_ID:int = 1;
       
      
      private var _critical:Bitmap;
      
      private var _normal:Bitmap;
      
      private var _stunIndicator:StunArrow;
      
      private var _buffIndicator:StatusArrow;
      
      private var _statusAnimationTimeoutID:int = -1;
      
      private var _state:String = "";
      
      private var _name:String;
      
      private var _tankmanHit:DamagePanelItemClickArea;
      
      private var _animInProgress:Boolean = false;
      
      private var _activeStatusID:int = -1;
      
      private var _isOtherStatusActive:Boolean = false;
      
      private var _isDisposed:Boolean = false;
      
      public function TankmanAssets(param1:String, param2:String, param3:String, param4:int, param5:int, param6:int)
      {
         super();
         this._name = param1;
         var _loc7_:Class = App.utils.classFactory.getClass(param2);
         var _loc8_:Class = App.utils.classFactory.getClass(param3);
         this._normal = new Bitmap(new _loc7_());
         this._critical = new Bitmap(new _loc8_());
         this._tankmanHit = new DamagePanelItemClickArea(param1,this._critical.width,this._critical.height,TANKMAN_HIT_AREA_PADDING);
         this._stunIndicator = App.utils.classFactory.getComponent(STUN_ARROW_LINKAGE,StunArrow);
         this._buffIndicator = App.utils.classFactory.getComponent(BUFF_ARROW_LINKAGE,StatusArrow);
         var _loc9_:int = (DamagePanel.PANEL_WIDTH - param5 * X_STEP >> 1) + X_OFFSET;
         var _loc10_:int = _loc9_ + X_STEP * param4;
         var _loc11_:int = Y_POS;
         this.state = BATTLE_ITEM_STATES.NORMAL;
         this._tankmanHit.x = this._critical.x = this._normal.x = _loc10_ + param6;
         this._tankmanHit.y = this._critical.y = this._normal.y = _loc11_;
         this._stunIndicator.x = this._tankmanHit.x + X_STUN_OFFSET;
         this._stunIndicator.y = this._tankmanHit.y + Y_STUN_OFFSET;
         this._buffIndicator.x = this._tankmanHit.x + X_STUN_OFFSET;
         this._buffIndicator.y = this._tankmanHit.y + Y_STUN_OFFSET;
         this._tankmanHit.visible = false;
      }
      
      public final function dispose() : void
      {
         this.clearStunAnimationTimeout();
         this._stunIndicator.dispose();
         this._stunIndicator = null;
         this._buffIndicator.dispose();
         this._buffIndicator = null;
         this._tankmanHit.dispose();
         this._tankmanHit = null;
         this._critical.bitmapData.dispose();
         this._critical = null;
         this._normal.bitmapData.dispose();
         this._normal = null;
         this._isDisposed = true;
      }
      
      public function getDisplayItems() : Vector.<DisplayObject>
      {
         return new <DisplayObject>[this._critical,this._normal,this._stunIndicator,this._buffIndicator];
      }
      
      public function showDestroyed() : void
      {
         this._critical.visible = true;
         this._normal.visible = false;
         this._stunIndicator.visible = false;
         this._buffIndicator.visible = false;
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      public function set state(param1:String) : void
      {
         this._state = param1;
         var _loc2_:Boolean = this.state == BATTLE_ITEM_STATES.NORMAL;
         this._normal.visible = _loc2_;
         this._critical.visible = !_loc2_;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get mouseEventHitElement() : DamagePanelItemClickArea
      {
         return this._tankmanHit;
      }
      
      public function showStatus(param1:int, param2:Boolean, param3:int = 0) : void
      {
         if(param1 != STUN_STATUS_ID)
         {
            this._isOtherStatusActive = true;
         }
         if(!this._animInProgress || param1 == STUN_STATUS_ID)
         {
            this._activeStatusID = param1;
            if(param3 > 0)
            {
               this._statusAnimationTimeoutID = setTimeout(this.showStatusIndicator,param3,param1,param2);
            }
            else
            {
               this.showStatusIndicator(param1,param2);
            }
            this._animInProgress = true;
         }
      }
      
      private function showStatusIndicator(param1:int, param2:Boolean = true) : void
      {
         if(this._isDisposed)
         {
            return;
         }
         this.clearStunAnimationTimeout();
         if(param1 == STUN_STATUS_ID)
         {
            if(this._isOtherStatusActive)
            {
               this._buffIndicator.hideStatus();
            }
            this._stunIndicator.showStun(param2);
         }
         else if(param1 == BUFF_STATUS_ID && this._activeStatusID != STUN_STATUS_ID)
         {
            this._buffIndicator.showStatus(param2);
         }
      }
      
      public function hideStatus(param1:int, param2:Boolean) : void
      {
         this.clearStunAnimationTimeout();
         if(param1 != STUN_STATUS_ID)
         {
            this._isOtherStatusActive = false;
         }
         if(param1 == STUN_STATUS_ID)
         {
            this._stunIndicator.hideStun(param2);
            if(this._isOtherStatusActive)
            {
               this._buffIndicator.showStatus(false);
               this._activeStatusID = BUFF_STATUS_ID;
            }
            else
            {
               this._activeStatusID = Values.DEFAULT_INT;
            }
         }
         else
         {
            this._buffIndicator.hideStatus();
            this._activeStatusID = Values.DEFAULT_INT;
         }
         this._animInProgress = false;
      }
      
      private function clearStunAnimationTimeout() : void
      {
         if(this._statusAnimationTimeoutID != Values.DEFAULT_INT)
         {
            clearTimeout(this._statusAnimationTimeoutID);
            this._statusAnimationTimeoutID = Values.DEFAULT_INT;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
   }
}
