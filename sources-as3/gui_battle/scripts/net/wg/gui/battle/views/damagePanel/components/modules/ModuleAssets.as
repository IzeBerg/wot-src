package net.wg.gui.battle.views.damagePanel.components.modules
{
   import fl.motion.easing.Cubic;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.events.RepairAnimEvent;
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemClickArea;
   import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelClickableItem;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.motion.Tween;
   
   public class ModuleAssets implements IDamagePanelClickableItem
   {
      
      public static const Y_STEP:int = 39;
      
      public static const TOP_Y_POSITION:int = 44;
      
      public static const TOP_POSITION_IDX_0:int = 0;
      
      public static const TOP_POSITION_IDX_1:int = 1;
      
      public static const TOP_POSITION_IDX_2:int = 2;
      
      public static const TOP_POSITION_IDX_3:int = 3;
      
      private static const LEFT_X_POSITION:int = 5;
      
      private static const RIGHT_X_POSITION:int = 178;
      
      private static const CRITICAL_POSTFIX:String = "_orange";
      
      private static const DESTROYED_POSTFIX:String = "_red";
      
      private static const HIDE_TWEEN_TIME:int = 300;
       
      
      public var destroyAvailability:Boolean = true;
      
      private var _repairAnim:ModuleRepairAnim;
      
      private var _warningAnim:ModuleWarningAnim;
      
      private var _critical:Bitmap;
      
      private var _destroyed:Bitmap;
      
      private var _iconHolder:Sprite;
      
      private var _iconHolderTween:Tween;
      
      private var _name:String;
      
      private var _modulesHit:DamagePanelItemClickArea;
      
      private var _isFullRepairAnimInProgress:Boolean = false;
      
      private var _moduleState:ModuleStateAdapter;
      
      public function ModuleAssets(param1:String, param2:Boolean, param3:int)
      {
         this._moduleState = new ModuleStateAdapter();
         super();
         this._name = param1;
         var _loc4_:IClassFactory = App.utils.classFactory;
         var _loc5_:IAtlasManager = App.atlasMgr;
         this._repairAnim = _loc4_.getComponent(Linkages.MODULE_REPAIR_ANIM,ModuleRepairAnim);
         this._repairAnim.addEventListener(RepairAnimEvent.ANIM_COMPLETE,this.onRepairAnimCompleteHandler);
         this._repairAnim.addEventListener(RepairAnimEvent.ANIM_HIDE,this.onRepairAnimHideHandler);
         this._warningAnim = _loc4_.getComponent(Linkages.MODULE_WARNING_ANIM,MovieClip);
         this._iconHolder = new Sprite();
         this._critical = new Bitmap(_loc5_.getNewBitmapData(ATLAS_CONSTANTS.BATTLE_ATLAS,param1 + CRITICAL_POSTFIX));
         this._destroyed = new Bitmap(_loc5_.getNewBitmapData(ATLAS_CONSTANTS.BATTLE_ATLAS,param1 + DESTROYED_POSTFIX));
         this._iconHolder.addChild(this._critical);
         this._iconHolder.addChild(this._destroyed);
         this._iconHolder.visible = false;
         this._iconHolderTween = new Tween(HIDE_TWEEN_TIME,this._iconHolder,{"alpha":0},{
            "paused":true,
            "ease":Cubic.easeOut,
            "onComplete":this.iconsHideCompleteHandler
         });
         this._modulesHit = new DamagePanelItemClickArea(param1,this._critical.width,this._critical.height,0);
         this._critical.visible = false;
         this._destroyed.visible = false;
         this._repairAnim.visible = false;
         this._warningAnim.visible = false;
         this._modulesHit.visible = false;
         var _loc6_:int = LEFT_X_POSITION;
         if(!param2)
         {
            _loc6_ = RIGHT_X_POSITION;
            this._warningAnim.scaleX = -this._warningAnim.scaleX;
            this._warningAnim.x = _loc6_ + this._critical.width;
         }
         else
         {
            this._warningAnim.x = _loc6_;
         }
         this._modulesHit.x = this._critical.x = this._destroyed.x = this._repairAnim.x = _loc6_;
         var _loc7_:int = TOP_Y_POSITION + param3 * Y_STEP;
         this._modulesHit.y = this._critical.y = this._destroyed.y = this._repairAnim.y = this._warningAnim.y = _loc7_;
         this.state = BATTLE_ITEM_STATES.NORMAL;
      }
      
      public final function dispose() : void
      {
         if(this._iconHolderTween)
         {
            this._iconHolderTween.dispose();
            this._iconHolderTween = null;
         }
         this._repairAnim.removeEventListener(RepairAnimEvent.ANIM_COMPLETE,this.onRepairAnimCompleteHandler);
         this._repairAnim.removeEventListener(RepairAnimEvent.ANIM_HIDE,this.onRepairAnimHideHandler);
         this._modulesHit.dispose();
         this._modulesHit = null;
         this._critical.bitmapData = null;
         this._critical = null;
         this._destroyed.bitmapData = null;
         this._destroyed = null;
         this._repairAnim.dispose();
         this._repairAnim = null;
         this._warningAnim.dispose();
         this._warningAnim = null;
         this._iconHolder = null;
      }
      
      public function getDisplayItems() : Vector.<DisplayObject>
      {
         return new <DisplayObject>[this._iconHolder,this._repairAnim,this._warningAnim];
      }
      
      public function hideAsset() : void
      {
         this._critical.visible = false;
         this._destroyed.visible = false;
         this._repairAnim.visible = false;
         this._warningAnim.visible = false;
         this._modulesHit.visible = false;
         this._iconHolder.visible = false;
         this._iconHolderTween.paused = true;
      }
      
      public function resetModule() : void
      {
         this.destroyAvailability = true;
         this.applyState(this._moduleState.updateState(BATTLE_ITEM_STATES.NORMAL,true));
      }
      
      public function resetModuleRepairing() : void
      {
         this.applyState(this._moduleState.updateState(BATTLE_ITEM_STATES.NORMAL,true));
      }
      
      public function setModuleRepairing(param1:int, param2:int, param3:Boolean = false) : void
      {
         this._repairAnim.setRepairSeconds(param1,param2,param3);
      }
      
      public function setPlaybackSpeed(param1:Number) : void
      {
         this._repairAnim.setPlaybackSpeed(param1);
      }
      
      public function setRepairTimeVisible(param1:Boolean) : void
      {
         this._repairAnim.setRepairTimeVisible(param1);
      }
      
      public function showDestroyed() : void
      {
         this.applyState(this._moduleState.updateState(BATTLE_ITEM_STATES.DESTROYED));
      }
      
      private function applyState(param1:int) : void
      {
         this._isFullRepairAnimInProgress = false;
         this._warningAnim.visible = false;
         this._critical.visible = false;
         this._destroyed.visible = false;
         this._warningAnim.visible = false;
         this._iconHolder.visible = false;
         this._iconHolder.alpha = 1;
         this._iconHolderTween.paused = true;
         switch(param1)
         {
            case ModuleStateAdapter.STATE_NORMAL:
               this._repairAnim.state = BATTLE_ITEM_STATES.NORMAL;
               break;
            case ModuleStateAdapter.STATE_DESTROYED:
               this._destroyed.visible = true;
               break;
            case ModuleStateAdapter.STATE_CRITICAL:
               this._critical.visible = true;
               break;
            case ModuleStateAdapter.STATE_NORMAL_TO_CRITICAL:
               this._warningAnim.visible = true;
               this._warningAnim.gotoAndPlay(1);
               this._critical.visible = true;
               this._repairAnim.state = BATTLE_ITEM_STATES.CRITICAL;
               break;
            case ModuleStateAdapter.STATE_NORMAL_TO_DESTROYED:
               this._warningAnim.visible = true;
               this._warningAnim.gotoAndPlay(1);
               this._destroyed.visible = true;
               this._repairAnim.state = BATTLE_ITEM_STATES.DESTROYED;
               break;
            case ModuleStateAdapter.STATE_CRITICAL_TO_DESTROYED:
               this._warningAnim.visible = true;
               this._warningAnim.gotoAndPlay(1);
               this._destroyed.visible = true;
               this._repairAnim.state = BATTLE_ITEM_STATES.DESTROYED;
               break;
            case ModuleStateAdapter.STATE_CRITICAL_TO_NORMAL:
               this._critical.visible = true;
               this._repairAnim.state = BATTLE_ITEM_STATES.REPAIRED_FULL;
               this._isFullRepairAnimInProgress = true;
               break;
            case ModuleStateAdapter.STATE_DESTROYED_TO_CRITICAL:
               this._critical.visible = true;
               this._repairAnim.state = BATTLE_ITEM_STATES.REPAIRED;
               break;
            case ModuleStateAdapter.STATE_DESTROYED_TO_NORMAL:
               this._destroyed.visible = true;
               this._repairAnim.state = BATTLE_ITEM_STATES.REPAIRED_FULL;
               this._isFullRepairAnimInProgress = true;
         }
         var _loc2_:Boolean = this._destroyed.visible || this._critical.visible;
         this._iconHolder.visible = _loc2_;
         this._iconHolder.alpha = int(_loc2_);
      }
      
      private function iconsHideCompleteHandler() : void
      {
         this._iconHolder.visible = this._critical.visible = this._destroyed.visible = false;
      }
      
      public function get state() : String
      {
         return this._moduleState.getExternalNamedState();
      }
      
      public function set state(param1:String) : void
      {
         if(this.destroyAvailability)
         {
            this.applyState(this._moduleState.updateState(param1));
         }
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get mouseEventHitElement() : DamagePanelItemClickArea
      {
         return this._modulesHit;
      }
      
      private function onRepairAnimCompleteHandler(param1:RepairAnimEvent) : void
      {
         var _loc2_:String = this._repairAnim.state;
         if(_loc2_ == BATTLE_ITEM_STATES.REPAIRED || _loc2_ == BATTLE_ITEM_STATES.REPAIRED_FULL)
         {
            this._repairAnim.state = BATTLE_ITEM_STATES.NORMAL;
         }
         this._moduleState.changeStateAfterAnimationComplete();
      }
      
      private function onRepairAnimHideHandler(param1:RepairAnimEvent) : void
      {
         if(this._isFullRepairAnimInProgress)
         {
            this._isFullRepairAnimInProgress = false;
            this._iconHolderTween.reset();
            this._iconHolderTween.paused = false;
         }
      }
   }
}

import net.wg.data.constants.generated.BATTLE_ITEM_STATES;

class ModuleStateAdapter
{
   
   public static const STATE_NORMAL:int = 0;
   
   public static const STATE_CRITICAL:int = 1;
   
   public static const STATE_DESTROYED:int = 2;
   
   public static const STATE_NORMAL_TO_CRITICAL:int = 3;
   
   public static const STATE_NORMAL_TO_DESTROYED:int = 4;
   
   public static const STATE_CRITICAL_TO_NORMAL:int = 5;
   
   public static const STATE_CRITICAL_TO_DESTROYED:int = 6;
   
   public static const STATE_DESTROYED_TO_NORMAL:int = 7;
   
   public static const STATE_DESTROYED_TO_CRITICAL:int = 8;
   
   private static const UPDATE_STATE_MSG:String = "[ ModuleStateAdapter | updateState ] default : ";
   
   private static const CHANGE_AFTER_ANIM_COMPLETE_MSG:String = "[ ModuleStateAdapter | changeStateAfterAnimationComplete ] default : ";
    
   
   private var _state:int = 0;
   
   private var _prevRawState:String = "normal";
   
   private var _waitForNextState:Boolean = false;
   
   function ModuleStateAdapter()
   {
      super();
   }
   
   public function updateState(param1:String, param2:Boolean = false) : int
   {
      if(param2)
      {
         this._waitForNextState = false;
      }
      if(this._waitForNextState && param1 == this._prevRawState)
      {
         return this._state;
      }
      this._waitForNextState = false;
      var _loc3_:int = STATE_NORMAL;
      switch(param1)
      {
         case BATTLE_ITEM_STATES.DESTROYED:
            if(param2)
            {
               _loc3_ = STATE_DESTROYED;
            }
            else if(this._prevRawState == BATTLE_ITEM_STATES.NORMAL || this._prevRawState == BATTLE_ITEM_STATES.REPAIRED_FULL)
            {
               _loc3_ = STATE_NORMAL_TO_DESTROYED;
            }
            else if(this._prevRawState == BATTLE_ITEM_STATES.CRITICAL || this._prevRawState == BATTLE_ITEM_STATES.REPAIRED)
            {
               _loc3_ = STATE_CRITICAL_TO_DESTROYED;
            }
            else if(this._prevRawState == BATTLE_ITEM_STATES.DESTROYED)
            {
               if(this._state == STATE_CRITICAL_TO_DESTROYED || this._state == STATE_NORMAL_TO_DESTROYED)
               {
                  _loc3_ = this._state;
               }
               else
               {
                  _loc3_ = STATE_DESTROYED;
               }
            }
            break;
         case BATTLE_ITEM_STATES.CRITICAL:
            if(param2)
            {
               _loc3_ = STATE_CRITICAL;
            }
            else if(this._prevRawState == BATTLE_ITEM_STATES.NORMAL || this._prevRawState == BATTLE_ITEM_STATES.REPAIRED_FULL)
            {
               _loc3_ = STATE_NORMAL_TO_CRITICAL;
            }
            else if(this._prevRawState == BATTLE_ITEM_STATES.DESTROYED)
            {
               _loc3_ = STATE_DESTROYED_TO_CRITICAL;
            }
            else if(this._prevRawState == BATTLE_ITEM_STATES.CRITICAL)
            {
               _loc3_ = STATE_CRITICAL;
            }
            break;
         case BATTLE_ITEM_STATES.NORMAL:
            if(param2)
            {
               _loc3_ = STATE_NORMAL;
            }
            else if(this._prevRawState == BATTLE_ITEM_STATES.DESTROYED)
            {
               this._waitForNextState = true;
               _loc3_ = STATE_DESTROYED_TO_NORMAL;
            }
            else if(this._prevRawState == BATTLE_ITEM_STATES.CRITICAL || this._prevRawState == BATTLE_ITEM_STATES.REPAIRED)
            {
               this._waitForNextState = true;
               _loc3_ = STATE_CRITICAL_TO_NORMAL;
            }
            break;
         case BATTLE_ITEM_STATES.REPAIRED:
            if(this._prevRawState == BATTLE_ITEM_STATES.DESTROYED || this._prevRawState == BATTLE_ITEM_STATES.CRITICAL)
            {
               _loc3_ = STATE_DESTROYED_TO_CRITICAL;
            }
            break;
         case BATTLE_ITEM_STATES.REPAIRED_FULL:
            if(this._prevRawState == BATTLE_ITEM_STATES.DESTROYED)
            {
               this._waitForNextState = true;
               _loc3_ = STATE_DESTROYED_TO_NORMAL;
            }
            else if(this._prevRawState == BATTLE_ITEM_STATES.CRITICAL || this._prevRawState == BATTLE_ITEM_STATES.REPAIRED)
            {
               this._waitForNextState = true;
               _loc3_ = STATE_CRITICAL_TO_NORMAL;
            }
            break;
         default:
            DebugUtils.LOG_DEBUG(UPDATE_STATE_MSG,param1);
      }
      this._prevRawState = param1;
      this._state = _loc3_;
      return this._state;
   }
   
   public function changeStateAfterAnimationComplete() : int
   {
      switch(this._state)
      {
         case STATE_DESTROYED_TO_CRITICAL:
         case STATE_NORMAL_TO_CRITICAL:
            this._state = STATE_CRITICAL;
            break;
         case STATE_DESTROYED_TO_NORMAL:
         case STATE_CRITICAL_TO_NORMAL:
            this._state = STATE_NORMAL;
            break;
         case STATE_CRITICAL_TO_DESTROYED:
         case STATE_NORMAL_TO_DESTROYED:
            this._state = STATE_DESTROYED;
            break;
         default:
            DebugUtils.LOG_DEBUG(CHANGE_AFTER_ANIM_COMPLETE_MSG,this._state);
      }
      this._waitForNextState = false;
      return this._state;
   }
   
   public function getExternalNamedState() : String
   {
      var _loc1_:String = BATTLE_ITEM_STATES.NORMAL;
      switch(this._state)
      {
         case STATE_DESTROYED:
         case STATE_CRITICAL_TO_DESTROYED:
         case STATE_NORMAL_TO_DESTROYED:
            _loc1_ = BATTLE_ITEM_STATES.DESTROYED;
            break;
         case STATE_CRITICAL:
         case STATE_NORMAL_TO_CRITICAL:
         case STATE_DESTROYED_TO_CRITICAL:
            _loc1_ = BATTLE_ITEM_STATES.CRITICAL;
            break;
         case STATE_NORMAL:
         case STATE_DESTROYED_TO_NORMAL:
         case STATE_CRITICAL_TO_NORMAL:
            _loc1_ = BATTLE_ITEM_STATES.NORMAL;
      }
      return _loc1_;
   }
}
