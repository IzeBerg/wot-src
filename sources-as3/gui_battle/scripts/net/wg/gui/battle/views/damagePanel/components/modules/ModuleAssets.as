package net.wg.gui.battle.views.damagePanel.components.modules
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemClickArea;
   import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelClickableItem;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.utils.IClassFactory;
   
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
       
      
      public var destroyAvailability:Boolean = true;
      
      private var _repairAnim:ModuleRepairAnim;
      
      private var _warningAnim:ModuleWarningAnim;
      
      private var _critical:Bitmap;
      
      private var _destroyed:Bitmap;
      
      private var _state:String = "normal";
      
      private var _name:String;
      
      private var _modulesHit:DamagePanelItemClickArea;
      
      private var _isDestroyed:Boolean = false;
      
      public function ModuleAssets(param1:String, param2:Boolean, param3:int)
      {
         super();
         this._name = param1;
         var _loc4_:IClassFactory = App.utils.classFactory;
         var _loc5_:IAtlasManager = App.atlasMgr;
         this._repairAnim = _loc4_.getComponent(Linkages.MODULE_REPAIR_ANIM,ModuleRepairAnim);
         this._warningAnim = _loc4_.getComponent(Linkages.MODULE_WARNING_ANIM,MovieClip);
         this._critical = new Bitmap(_loc5_.getNewBitmapData(ATLAS_CONSTANTS.BATTLE_ATLAS,param1 + CRITICAL_POSTFIX));
         this._destroyed = new Bitmap(_loc5_.getNewBitmapData(ATLAS_CONSTANTS.BATTLE_ATLAS,param1 + DESTROYED_POSTFIX));
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
      }
      
      public function getDisplayItems() : Vector.<DisplayObject>
      {
         return new <DisplayObject>[this._critical,this._destroyed,this._repairAnim,this._warningAnim];
      }
      
      public function hideAsset() : void
      {
         this._critical.visible = false;
         this._destroyed.visible = false;
         this._repairAnim.visible = false;
         this._warningAnim.visible = false;
         this._modulesHit.visible = false;
      }
      
      public function resetModule() : void
      {
         this.destroyAvailability = true;
         this._state = BATTLE_ITEM_STATES.NORMAL;
         this._critical.visible = false;
         this._destroyed.visible = false;
         this._warningAnim.visible = false;
         this._modulesHit.visible = false;
         this._repairAnim.state = BATTLE_ITEM_STATES.NORMAL;
      }
      
      public function resetModuleRepairing() : void
      {
         this._repairAnim.state = BATTLE_ITEM_STATES.NORMAL;
      }
      
      public function setModuleRepairing(param1:int, param2:int) : void
      {
         this._repairAnim.setRepairSeconds(param1,param2);
      }
      
      public function setPlaybackSpeed(param1:Number) : void
      {
         this._repairAnim.setPlaybackSpeed(param1);
      }
      
      public function showDestroyed() : void
      {
         this._isDestroyed = true;
         this.state = BATTLE_ITEM_STATES.DESTROYED;
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      public function set state(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:String = null;
         if(this.destroyAvailability && (this._state != param1 || this._isDestroyed))
         {
            _loc2_ = this._state;
            this._state = param1;
            this._critical.visible = this._state == BATTLE_ITEM_STATES.CRITICAL || this._state == BATTLE_ITEM_STATES.REPAIRED;
            this._destroyed.visible = this._state == BATTLE_ITEM_STATES.DESTROYED;
            _loc3_ = this._state == BATTLE_ITEM_STATES.CRITICAL || this._state == BATTLE_ITEM_STATES.DESTROYED;
            this._warningAnim.visible = _loc3_;
            if(_loc3_)
            {
               this._warningAnim.gotoAndPlay(1);
            }
            _loc4_ = (this._state == BATTLE_ITEM_STATES.NORMAL || this._state == BATTLE_ITEM_STATES.REPAIRED) && _loc2_ != BATTLE_ITEM_STATES.NORMAL || this._isDestroyed;
            if(_loc4_)
            {
               _loc5_ = this.state;
               if(this._state == BATTLE_ITEM_STATES.NORMAL)
               {
                  _loc5_ = BATTLE_ITEM_STATES.REPAIRED_FULL;
               }
               else if(this._state == BATTLE_ITEM_STATES.CRITICAL && this._isDestroyed)
               {
                  _loc5_ = BATTLE_ITEM_STATES.REPAIRED_FULL;
               }
               this._repairAnim.state = _loc5_;
            }
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
      
      public function setRepairTimeVisible(param1:Boolean) : void
      {
         this._repairAnim.setRepairTimeVisible(param1);
      }
   }
}
