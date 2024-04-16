package net.wg.gui.lobby.fortifications.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
   import net.wg.gui.fortBase.IBuildingVO;
   import net.wg.gui.lobby.fortifications.data.base.BuildingBaseVO;
   import net.wg.utils.IAssertable;
   
   public class BuildingVO extends BuildingBaseVO implements IBuildingVO
   {
      
      private static const TOOLTIP_DATA:String = "toolTipData";
      
      private static const TRANSPORT_TOOLTIP_DATA:String = "transportTooltipData";
       
      
      private var _isDefenceHour:Boolean = false;
      
      private var _orderTime:String = "";
      
      private var _direction:int = -1;
      
      private var _position:int = 0;
      
      private var _directionType:int = 0;
      
      private var _cooldown:String = "";
      
      private var _progress:int = -1;
      
      private var _isAvailable:Boolean = true;
      
      private var _isExportAvailable:Boolean = false;
      
      private var _isImportAvailable:Boolean = false;
      
      private var _isLevelUp:Boolean = false;
      
      private var _isOpenCtxMenu:Boolean = false;
      
      private var _productionInPause:Boolean = false;
      
      private var _underAttack:Boolean = false;
      
      private var _looted:Boolean = false;
      
      private var _isBaseBuildingDamaged:Boolean = false;
      
      private var _isFortFrozen:Boolean = false;
      
      private var _toolTipData:Vector.<String>;
      
      private var _transportTooltipData:Vector.<String>;
      
      private var _asserter:IAssertable;
      
      public function BuildingVO(param1:Object)
      {
         this._toolTipData = new Vector.<String>();
         this._transportTooltipData = new Vector.<String>();
         this._asserter = App.utils.asserter;
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         if(TOOLTIP_DATA == param1)
         {
            _loc3_ = param2 as Array;
            this._asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + TOOLTIP_DATA);
            for each(_loc4_ in _loc3_)
            {
               this._toolTipData.push(_loc4_);
            }
            return false;
         }
         if(TRANSPORT_TOOLTIP_DATA == param1)
         {
            _loc5_ = param2 as Array;
            if(_loc5_)
            {
               for each(_loc6_ in _loc5_)
               {
                  this._transportTooltipData.push(_loc6_);
               }
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._toolTipData.splice(0,this._toolTipData.length);
         this._toolTipData = null;
         this._transportTooltipData.splice(0,this._transportTooltipData.length);
         this._transportTooltipData = null;
         this._asserter = null;
         super.onDispose();
      }
      
      public final function validate() : void
      {
         var _loc1_:Boolean = false;
         if(this._isExportAvailable)
         {
            _loc1_ = this._progress == FORTIFICATION_ALIASES.STATE_BUILDING;
            this._asserter.assert(_loc1_,"non-completed building " + uid + " can not be available to exporting");
         }
      }
      
      public function get isInFoundationState() : Boolean
      {
         return this._progress > FORTIFICATION_ALIASES.STATE_TROWEL && this._progress < FORTIFICATION_ALIASES.STATE_BUILDING;
      }
      
      public function get toolTipData() : Vector.<String>
      {
         return this._toolTipData;
      }
      
      public function get transportTooltipData() : Vector.<String>
      {
         return this._transportTooltipData;
      }
      
      public function get isDefenceHour() : Boolean
      {
         return this._isDefenceHour;
      }
      
      public function set isDefenceHour(param1:Boolean) : void
      {
         this._isDefenceHour = param1;
      }
      
      public function get orderTime() : String
      {
         return this._orderTime;
      }
      
      public function set orderTime(param1:String) : void
      {
         this._orderTime = param1;
      }
      
      public function get direction() : int
      {
         return this._direction;
      }
      
      public function set direction(param1:int) : void
      {
         this._direction = param1;
      }
      
      public function get position() : int
      {
         return this._position;
      }
      
      public function set position(param1:int) : void
      {
         this._position = param1;
      }
      
      public function get directionType() : int
      {
         return this._directionType;
      }
      
      public function set directionType(param1:int) : void
      {
         this._directionType = param1;
      }
      
      public function get cooldown() : String
      {
         return this._cooldown;
      }
      
      public function set cooldown(param1:String) : void
      {
         this._cooldown = param1;
      }
      
      public function get progress() : int
      {
         return this._progress;
      }
      
      public function set progress(param1:int) : void
      {
         this._progress = param1;
      }
      
      public function get isAvailable() : Boolean
      {
         return this._isAvailable;
      }
      
      public function set isAvailable(param1:Boolean) : void
      {
         this._isAvailable = param1;
      }
      
      public function get isExportAvailable() : Boolean
      {
         return this._isExportAvailable;
      }
      
      public function set isExportAvailable(param1:Boolean) : void
      {
         this._isExportAvailable = param1;
      }
      
      public function get isImportAvailable() : Boolean
      {
         return this._isImportAvailable;
      }
      
      public function set isImportAvailable(param1:Boolean) : void
      {
         this._isImportAvailable = param1;
      }
      
      public function get isLevelUp() : Boolean
      {
         return this._isLevelUp;
      }
      
      public function set isLevelUp(param1:Boolean) : void
      {
         this._isLevelUp = param1;
      }
      
      public function get isOpenCtxMenu() : Boolean
      {
         return this._isOpenCtxMenu;
      }
      
      public function set isOpenCtxMenu(param1:Boolean) : void
      {
         this._isOpenCtxMenu = param1;
      }
      
      public function get productionInPause() : Boolean
      {
         return this._productionInPause;
      }
      
      public function set productionInPause(param1:Boolean) : void
      {
         this._productionInPause = param1;
      }
      
      public function get underAttack() : Boolean
      {
         return this._underAttack;
      }
      
      public function set underAttack(param1:Boolean) : void
      {
         this._underAttack = param1;
      }
      
      public function get looted() : Boolean
      {
         return this._looted;
      }
      
      public function set looted(param1:Boolean) : void
      {
         this._looted = param1;
      }
      
      public function get isBaseBuildingDamaged() : Boolean
      {
         return this._isBaseBuildingDamaged;
      }
      
      public function set isBaseBuildingDamaged(param1:Boolean) : void
      {
         this._isBaseBuildingDamaged = param1;
      }
      
      public function get isFortFrozen() : Boolean
      {
         return this._isFortFrozen;
      }
      
      public function set isFortFrozen(param1:Boolean) : void
      {
         this._isFortFrozen = param1;
      }
   }
}
